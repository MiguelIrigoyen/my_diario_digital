import 'package:flutter/material.dart';

class CrearEntrada extends StatefulWidget {
  @override
  _CrearEntradaState createState() => _CrearEntradaState();
}

class _CrearEntradaState extends State<CrearEntrada> {
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _notaTextoController = TextEditingController();
  String _notaVoz = '';
  Map<String, double>? _location;
  String _imageOrVideo = '';
  String _dateTime = DateTime.now().toIso8601String();

  void agregarFoto() async {
    // Aquí agregarías la lógica para seleccionar y enviar una foto
    print("Foto añadida exitosamente");
  }

  void agregarVideo() async {
    // Aquí agregarías la lógica para seleccionar y enviar un video
    print("Video agregado correctamente.");
  }

  void grabarAudio() async {
    // Aquí agregarías la lógica para grabar y enviar el audio
    setState(() {
      _notaVoz = "string_con_datos_de_audio";
    });
    print("Audio grabado correctamente.");
  }

  void realizarDibujo() async {
    // Aquí agregarías la lógica para crear y enviar un dibujo
    print("Dibujo guardado correctamente.");
  }

  void guardarEntrada() async {
    // Aquí agregarías la lógica para guardar la entrada usando una API
    print("Entrada guardada correctamente.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Entrada'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _categoriaController,
                decoration: InputDecoration(labelText: 'Categoría'),
              ),
              TextField(
                controller: _notaTextoController,
                decoration: InputDecoration(labelText: 'Nota de texto'),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.photo),
                label: Text('Agregar Foto'),
                onPressed: agregarFoto,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.videocam),
                label: Text('Agregar Video'),
                onPressed: agregarVideo,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.mic),
                label: Text('Grabar Audio'),
                onPressed: grabarAudio,
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.brush),
                label: Text('Realizar Dibujo'),
                onPressed: realizarDibujo,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Guardar Entrada'),
                onPressed: guardarEntrada,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
