import 'package:flutter/material.dart';
//import 'calendario.dart';
//import 'configuracion.dart';
//import 'detallesentrada.dart';
import 'entradas.dart';
//import 'etiquetas.dart';
//import 'informacionyayuda.dart';
//import 'favoritosetiquetas.dart';
import 'exportacioncopias.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {git
    return MaterialApp(
      title: 'Mi Diario digital',
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => PantallaPrincipal(), // Pantalla principal
        //'/fEtiquetas':  (context) => ,
        '/Entradas':  (context) =>EntradasWidget() ,
        '/ecSeguridad': (context) => ExportarCopiaSeguridad(),
      },
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Principal'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegar a la pantalla de exportacion  y copia de seguridad
            Navigator.pushNamed(context, '/ecSeguridad');
          },
          child: Text('Exportacion y Copia de Seguridad'),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Navegar a la pantalla de exportacion  y copia de seguridad
                Navigator.pushNamed(context, '/ecSeguridad');
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Navegar a la entradas
                Navigator.pushNamed(context, '/entradas');
              },
            )
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(onPressed: null),
    );
  }
}