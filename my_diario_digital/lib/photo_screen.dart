import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  late List<CameraDescription> cameras;
  CameraController? controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Obtiene la lista de cámaras disponibles
    cameras = await availableCameras();

    // Inicializa la cámara seleccionada (normalmente la cámara trasera)
    controller = CameraController(cameras[0], ResolutionPreset.high);

    // Inicia el controlador de la cámara
    _initializeControllerFuture = controller!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    // Libera los recursos cuando ya no se necesita la cámara
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Foto'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Si la cámara está lista, muestra la vista previa
            return CameraPreview(controller!);
          } else {
            // Mientras se inicializa la cámara, muestra un indicador de carga
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // Asegúrate de que la cámara está inicializada
            await _initializeControllerFuture;

            // Toma una foto
            final image = await controller!.takePicture();

            // Muestra la imagen tomada en una nueva pantalla
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: image.path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Imagen tomada')),
      body: Image.file(File(imagePath)),
    );
  }
}