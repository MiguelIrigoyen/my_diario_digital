import 'package:flutter/material.dart';
import 'calendario.dart';
import 'configuracion.dart';
//import 'detallesentrada.dart';
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
        '/calendario': (context) => CalendarioScreen(), // Pantalla de calendario
        '/configuracion': (context) => ConfiguracionScreen(), // Pantalla de configuración
        //'/fEtiquetas':  (context) => ,
        //'/Entradas':  (context) =>EntradasWidget() ,
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
        backgroundColor: Colors.blue,
        title: Text('Pantalla Principal',
            style: TextStyle(color: Colors.white)
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navegar a la pantalla de configuración
              Navigator.pushNamed(context, '/configuracion');
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegar a la pantalla de exportacion  y copia de seguridad
            Navigator.pushNamed(context, '/ecSeguridad');
          },
          child: Text('Exportacion y Copia de Seguridad'),
        ),
        ElevatedButton(
          onPressed: () {
            // Navegar a la pantalla de calendario
            Navigator.pushNamed(context, '/calendario');
            },
            child: Text('Calendario'),
           ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
            // Navegar a la pantalla de calendario
            Navigator.pushNamed(context, '/calendario');
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
            // Navegar a la pantalla de configuración
            Navigator.pushNamed(context, '/configuracion');
            },
          ),
            IconButton(
              icon: Icon(Icons.search),
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
      floatingActionButton: const FloatingActionButton(onPressed: null),
    );
  }
}