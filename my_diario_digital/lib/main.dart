import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendario.dart';
import 'configuracion.dart';
import 'detallesentrada.dart';
// import 'etiquetas.dart';
// import 'informacionyayuda.dart';
import 'favoritosetiquetas.dart';
import 'mapa.dart';
import 'exportacioncopias.dart';
import 'visualizarEntrada.dart';
import 'basededatos.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await DatabaseHelper.instance.database;

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
        '/fEtiquetas': (context) => FavoritosScreen(),
        '/entradas': (context) => CrearEntrada(),
        '/ecSeguridad': (context) => ExportacionYCopia(),
        '/Inicio': (context) => PantallaPrincipal(),
        '/Calendario': (context) => CalendarioScreen(), // Ruta para Calendario
        '/Configuracion': (context) => ConfiguracionScreen (), // Ruta para Configuración
        '/Mapa': (context) => GoogleMapPage(),
        '/visualizarEntrada': (context) => PhotoGridScreen(),

      },
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  //final fbHelper=BaseDeDatos();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 4,
        title: Center(
          child: Text(
            'Pantalla Principal',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.home,
              text: 'Inicio',
              onTap: () {
                Navigator.pushNamed(context, '/Inicio');
              },
            ),
            _buildDrawerItem(
              icon: Icons.settings,
              text: 'Configuración',
              onTap: () {
                Navigator.pushNamed(context, '/Configuracion');
              },
            ),
            _buildDrawerItem(
              icon: Icons.calendar_today,
              text: 'Calendario',
              onTap: () {
                Navigator.pushNamed(context, '/Calendario');
              },
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              text: 'Cerrar sesión',
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
            Navigator.pushNamed(context, '/entradas');
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor: Colors.blueAccent,
            elevation: 5,
          ),
          child: Text(
            'Agregar entradada',
            style: TextStyle(fontSize: 16),
          ),
        ),
       /* child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed:(){
              _insert();
            },
              child: const Text('Insertar Datos'),
            ),
            ElevatedButton(onPressed:(){
              _mostrar();
            },
              child: const Text('Mostrar'),
            ),
          ],
        ),*/
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBottomNavItem(
                icon: Icons.home,
                onTap: () {
                  Navigator.pushNamed(context, '/Inicio');
                },
              ),
              _buildBottomNavItem(
                icon: Icons.archive_rounded,
                onTap: () {
                  Navigator.pushNamed(context, '/ecSeguridad');
                },
              ),
              _buildBottomNavItem(
                icon: Icons.image,
                onTap: () {
                  Navigator.pushNamed(context, '/visualizarEntrada');
                },
              ),
              _buildBottomNavItem(
                icon: Icons.auto_awesome_mosaic_rounded,
                onTap: () {
                  Navigator.pushNamed(context, '/entradas');
                },
              ),
              _buildBottomNavItem(
                icon: Icons.discount_sharp,
                onTap: () {
                  Navigator.pushNamed(context, '/fEtiquetas');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onTap,
      iconSize: 28,
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
    );
  }
}
