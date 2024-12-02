import 'package:flutter/material.dart';
//import 'calendario.dart';
//import 'configuracion.dart';
import 'detallesentrada.dart';
// 'entradas.dart';
//import 'etiquetas.dart';
//import 'informacionyayuda.dart';
//import 'favoritosetiquetas.dart';
import 'exportacioncopias.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Diario digital',
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => PantallaPrincipal(), // Pantalla principal
        //'/fEtiquetas':  (context) => ,
        '/entradas':  (context) =>CrearEntrada() ,
        '/ecSeguridad': (context) => ExportarCopiaSeguridad(),
        '/Inicio': (context) => PantallaPrincipal(),
      },
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:Center(
        child: Text('Pantalla Principal',

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
      Navigator.pushNamed(context, '/Inicio');
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
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegar a la pantalla de exportacion  y copia de seguridad
            Navigator.pushNamed(context, '/ecSeguridad');
          },
          child: Text('Exportacion y Copia de Seguridad'),
        ),
      ),
      //copiar este BottomNavigationBar en todas las pantallas
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamed(context, '/Inicio');
              },
            ),
            IconButton(
              icon: Icon(Icons.archive_rounded),
              onPressed: () {
                // Navegar a la pantalla de exportacion  y copia de seguridad
                Navigator.pushNamed(context, '/ecSeguridad');
              },
            ),
            IconButton(
              icon: Icon(Icons.add_box_outlined),
              onPressed: () {
                // Navegar a la entradas
                Navigator.pushNamed(context, '/entradas');
              },
            ),
            IconButton(
              icon: Icon(Icons.access_alarm),
              onPressed: () {
                // Navegar a la entradas
                Navigator.pushNamed(context, '/entradas');
              },
            ),
          ],
        ),
      ),
    );
  }
}