import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late List<CameraDescription> cameras;
  CameraController? controller;
  Future<void>? _initializeControllerFuture;

  bool _isRecording = false; // Indica si se está grabando un video

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Inicializa la cámara
  Future<void> _initializeCamera() async {
    cameras = await availableCameras();

    // Usa la cámara trasera
    controller = CameraController(cameras[0], ResolutionPreset.medium);

    _initializeControllerFuture = controller!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grabar Video'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Muestra la vista previa de la cámara
            return CameraPreview(controller!);
          } else {
            // Indicador de carga mientras se inicializa la cámara
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_isRecording) {
            // Si ya está grabando, detiene la grabación
            final videoFile = await controller!.stopVideoRecording();
            setState(() {
              _isRecording = false;
            });

            // Navega a la pantalla para reproducir el video
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayVideoScreen(videoPath: videoFile.path),
              ),
            );
          } else {
            // Inicia la grabación del video
            await _initializeControllerFuture;

            await controller!.startVideoRecording();
            setState(() {
              _isRecording = true;
            });
          }
        },
        child: Icon(_isRecording ? Icons.stop : Icons.videocam),
        backgroundColor: _isRecording ? Colors.red : Colors.blue,
      ),
    );
  }
}

// Pantalla para mostrar el video grabado
class DisplayVideoScreen extends StatefulWidget {
  final String videoPath;

  const DisplayVideoScreen({Key? key, required this.videoPath}) : super(key: key);

  @override
  _DisplayVideoScreenState createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Grabado')),
      body: Center(
        child: _videoController.value.isInitialized
            ? AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: VideoPlayer(_videoController),
        )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_videoController.value.isPlaying) {
              _videoController.pause();
            } else {
              _videoController.play();
            }
          });
        },
        child: Icon(
          _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
