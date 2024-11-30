import 'package:flutter/material.dart';
//import 'calendario.dart';
//import 'configuracion.dart';
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
              icon: Icon(Icons.account_balance_sharp),
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