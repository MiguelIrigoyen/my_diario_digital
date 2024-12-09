import 'package:flutter/material.dart';
import 'photo_screen.dart';
import 'video_screan.dart';
import 'mapa.dart';
class CrearEntrada extends StatefulWidget {
  @override
  _CrearEntradaState createState() => _CrearEntradaState();
}

class _CrearEntradaState extends State<CrearEntrada> {
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _notaTextoController = TextEditingController();
  String _notaVoz = '';
  Map<String, double>? _location;
  String _imageOrVideo = '';
  String _dateTime = DateTime.now().toIso8601String();

  void agregarFoto() async {
    // Aquí agregarías la lógica para seleccionar y enviar una foto
    print("Foto añadida exitosamente");
  }

  void agregarVideo() async {
    // Aquí agregarías la lógica para seleccionar y enviar un video
    print("Video agregado correctamente.");
  }

  void grabarAudio() async {
    // Aquí agregarías la lógica para grabar y enviar el audio
    setState(() {
      _notaVoz = "string_con_datos_de_audio";
    });
    print("Audio grabado correctamente.");
  }

  void realizarDibujo() async {
    // Aquí agregarías la lógica para crear y enviar un dibujo
    print("Dibujo guardado correctamente.");
  }

  void guardarEntrada() async {
    // Aquí agregarías la lógica para guardar la entrada usando una API
    print("Entrada guardada correctamente.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Entrada'),
        backgroundColor: Colors.blue,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _categoriaController,
                decoration: InputDecoration(labelText: 'Categoría'),
              ),
              TextField(
                controller: _notaTextoController,
                decoration: InputDecoration(labelText: 'Nota de texto'),
              ),
              SizedBox(height: 17),
              ElevatedButton.icon(
                icon: Icon(Icons.camera),
                label: Text('Agregar Foto'),
                onPressed:(){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => PhotoScreen()),
                  );
                }
              ),
              SizedBox(height: 17),
              ElevatedButton.icon(
                icon: Icon(Icons.videocam),
                label: Text('Agregar Video'),
                  onPressed:(){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => VideoScrean()),
                    );
                  }
              ),
              SizedBox(height: 17),
              ElevatedButton.icon(
                icon: Icon(Icons.mic),
                label: Text('Grabar Audio'),
                onPressed: grabarAudio,
              ),
              SizedBox(height: 17),
              ElevatedButton.icon(
                icon: Icon(Icons.map_sharp),
                label: Text('Guardar Ubicación'),
                onPressed:(){
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GoogleMapPage()),
                  );
              },
              ),
              SizedBox(height: 17),
              ElevatedButton(
                child: Text('Guardar Entrada'),
                onPressed: guardarEntrada,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white),

                ),
              ),
            ],
          ),
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