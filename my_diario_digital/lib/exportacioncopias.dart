import 'package:flutter/material.dart';

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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Inicio'),
                onTap: () {
                  // Acción al presionar
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configuración'),
                onTap: () {
                  // Acción al presionar
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Cerrar sesión'),
                onTap: () {
                  // Acción al presionar
                },
              ),
            ],
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Llamar al método exportarEntrada
                exportarEntrada(1, "PDF");
              },
              child: Text('Exportar Entrada'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Llamar al método realizarCopiaSeguridad
                realizarCopiaSeguridad();
              },
              child: Text('Realizar Copia de Seguridad'),
            ),
            SizedBox(height: 16),
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

  void exportarEntrada(int idEntrada, String formato) {
    // Simula la lógica para exportar una entrada
    print('Exportando entrada con ID: $idEntrada en formato: $formato');
    // Aquí se llamaría a una API con un método GET.
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
