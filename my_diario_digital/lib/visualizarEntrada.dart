import 'dart:io';
import 'package:flutter/material.dart';
import 'basededatos.dart'; // Importa tu clase de base de datos
import 'pantallaFoto.dart'; // Importa la pantalla de foto en pantalla completa

class PhotoGridScreen extends StatefulWidget {
  @override
  _PhotoGridScreenState createState() => _PhotoGridScreenState();
}

class _PhotoGridScreenState extends State<PhotoGridScreen> {
  List<Map<String, dynamic>> _photos = []; // Lista de fotos desde la base de datos

  @override
  void initState() {
    super.initState();
    _loadPhotos(); // Cargar fotos al iniciar
  }

  // Método para cargar las fotos desde la base de datos
  Future<void> _loadPhotos() async {
    final photos = await DatabaseHelper.instance.getAllMediaFiles();
    setState(() {
      _photos = photos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Fotos'),
      ),
      body: _photos.isEmpty
          ? Center(child: Text('No hay fotos guardadas'))
          : GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.75, // Ajusta la altura de los elementos
        ),
        itemCount: _photos.length,
        itemBuilder: (context, index) {
          final photo = _photos[index];
          return GestureDetector(
            onTap: () {
              // Navegar a la pantalla de pantalla completa
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PhotoFullScreen(imagePath: photo['file_path']),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Hero(
                    tag: photo['file_path'],
                    child: Image.file(
                      File(photo['file_path']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Categoría: ${photo['category'] ?? 'Sin categoría'}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Nota: ${photo['note'] ?? 'Sin nota'}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
