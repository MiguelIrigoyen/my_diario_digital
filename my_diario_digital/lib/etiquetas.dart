import 'dart:io';
import 'package:flutter/material.dart';
import 'basededatos.dart'; // Asegúrate de importar tu clase de base de datos.

class PhotoDescriptionScreen extends StatelessWidget {
  final String imagePath;

  PhotoDescriptionScreen({required this.imagePath});

  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  // Método para guardar los datos en la base de datos
  Future<void> _saveToDatabase(BuildContext context) async {
    final category = _categoryController.text;
    final note = _noteController.text;

    if (category.isNotEmpty && note.isNotEmpty) {
      // Crea un mapa con los datos para la base de datos
      Map<String, dynamic> mediaFile = {
        'file_path': imagePath,
        'type': 'photo', // Tipo de archivo
        'category': category,
        'note': note,
      };

      // Inserta la foto en la base de datos
      await DatabaseHelper.instance.insertMediaFile(mediaFile);

      // Muestra un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Foto guardada con éxito')),
      );

      // Vuelve a la pantalla principal o anterior
      Navigator.pop(context);
    } else {
      // Si faltan datos, muestra un mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingresa todos los datos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Foto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mostrar la imagen tomada
            Center(
              child: Image.file(
                File(imagePath),
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            // Campo para la categoría
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Categoría',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            // Campo para la nota
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Nota',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            // Botón para guardar los datos
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _saveToDatabase(context),
                icon: Icon(Icons.save),
                label: Text('Guardar Foto'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
