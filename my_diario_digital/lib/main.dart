import 'package:flutter/material.dart';
import 'calendario.dart';
import 'configuracion.dart';
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
        '/Calendario': (context) => Calendario(),
        '/Configuracion': (context) => Configuracion(),
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
        title: Center(
          child: Text(
            'Pantalla Principal',
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
                Navigator.pushNamed(context, '/Configuracion');
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calendario'),
              onTap: () {
                Navigator.pushNamed(context, '/Calendario');
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
                Navigator.pushNamed(context, '/ecSeguridad');
              },
            ),
            IconButton(
              icon: Icon(Icons.add_box_outlined),
              onPressed: () {
                Navigator.pushNamed(context, '/entradas');
              },
            ),
            IconButton(
              icon: Icon(Icons.access_alarm),
              onPressed: () {
                Navigator.pushNamed(context, '/entradas');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Calendario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Calendario de Entradas'),
            ElevatedButton(
              onPressed: () {
                // Lógica para obtener entradas por fecha
                print('Obteniendo entradas por fecha');
              },
              child: Text('Obtener Entradas'),
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
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamed(context, '/Inicio');
              },
            ),
            IconButton(
              icon: Icon(Icons.archive_rounded),
              onPressed: () {
                Navigator.pushNamed(context, '/ecSeguridad');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Configuracion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Configurar permisos de cámara'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Lógica para actualizar permiso
                print('Permiso de cámara actualizado: $value');
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Cambiar tema'),
            onTap: () {
              // Lógica para cambiar tema
              print('Cambiando tema');
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Ajustar notificaciones'),
            trailing: Switch(
              value: false,
              onChanged: (value) {
                // Lógica para ajustar notificaciones
                print('Notificaciones actualizadas: $value');
              },
            ),
          ),
        ],
      ),
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
                Navigator.pushNamed(context, '/ecSeguridad');
              },
            ),
          ],
        ),
      ),
    );
  }
}
