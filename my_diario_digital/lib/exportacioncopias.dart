import 'package:flutter/material.dart';
import 'package:my_diario_digital/urls.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ExportarCopiaSeguridad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title:Center(
            child: Text('Exportacion y copia de seguridad',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 300),
            ElevatedButton(
              onPressed: () {
                // Llamar al método exportarEntrada
                exportarEntrada(1, "PDF");
              },
              child: Text('Exportar Entrada'),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Llamar al método realizarCopiaSeguridad
                realizarCopiaSeguridad();
              },
              child: Text('Realizar Copia de Seguridad'),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Llamar al método restaurarCopiaSeguridad
                restaurarCopiaSeguridad('ruta/archivo.backup');
              },
              child: Text('Restaurar Copia de Seguridad'),
            ),
          ],
        ),
      ),

    );
  }


  Future<void> exportarEntrada(int idEntrada, String formato) async {
    final url = Uri.parse(urls.url);

    try {
      final response = await http.get(
        url.replace(queryParameters: {
          'idEntrada': idEntrada.toString(),
          'formato': formato,
        }),
      );

      if (response.statusCode == 200) {
        print('Entrada exportada correctamente: ${response.body}');
        // Aquí puedes manejar el archivo descargado, si aplica.
      } else {
        print('Error al exportar la entrada: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud GET: $e');
    }
  }


  Future<bool> realizarCopiaSeguridad() async {
    // Simula la lógica para realizar una copia de seguridad
    print('Realizando copia de seguridad...');
    // Aquí se llamaría a una API con un método POST.
    await Future.delayed(Duration(seconds: 1)); // Simulación de un proceso
    print('Copia de seguridad realizada con éxito.');
    return true;
  }

  Future<bool> restaurarCopiaSeguridad(String archivo) async {
    // Simula la lógica para restaurar una copia de seguridad desde un archivo
    print('Restaurando copia de seguridad desde el archivo: $archivo');
    // Aquí se llamaría a una API con un método POST.
    await Future.delayed(Duration(seconds: 2)); // Simulación de un proceso
    print('Copia de seguridad restaurada con éxito.');
    return true;
  }
}
