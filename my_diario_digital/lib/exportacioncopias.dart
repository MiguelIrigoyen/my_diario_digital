import 'package:flutter/material.dart';
import 'dart:convert';
import 'basededatos.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ExportacionYCopia extends StatefulWidget {
  @override
  _ExportacionYCopiaState createState() => _ExportacionYCopiaState();
}

class _ExportacionYCopiaState extends State<ExportacionYCopia> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> realizarCopiaSeguridad() async {
    try {
      await _dbHelper.backupData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Copia de seguridad realizada con éxito')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al realizar la copia de seguridad: $e')),
      );
    }
  }

  Future<void> restaurarCopiaSeguridad() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/media_backup.json';

      if (await File(filePath).exists()) {
        await _dbHelper.restoreData(filePath);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Datos restaurados con éxito')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Archivo de copia de seguridad no encontrado')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al restaurar los datos: $e')),
      );
    }
  }

  Future<void> exportarDatos() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final exportPath = '${directory.path}/exported_data.json';

      await _dbHelper.exportData(exportPath);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Datos exportados a: $exportPath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al exportar los datos: $e')),
      );
    }
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: realizarCopiaSeguridad,
              child: Text('Realizar Copia de Seguridad'),
            ),
            ElevatedButton(
              onPressed: restaurarCopiaSeguridad,
              child: Text('Restaurar Copia de Seguridad'),
            ),
            ElevatedButton(
              onPressed: exportarDatos,
              child: Text('Exportar Datos'),
            ),
          ],
        ),
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
}
//widgets para los appbar y bottom appbar
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
