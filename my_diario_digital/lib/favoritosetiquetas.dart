import 'package:flutter/material.dart';
/*
class FavoritosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FavoritosScreen(),
    );
  }
}
*/
class FavoritosScreen extends StatefulWidget {
  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  List<String> favoritos = []; // Lista simulada de favoritos
  TextEditingController etiquetaController = TextEditingController();
  TextEditingController buscarEtiquetaController = TextEditingController();

  // Simulación de la función verFavoritos()
  void verFavoritos() {
    setState(() {
      favoritos = ["Entrada 1", "Entrada 2", "Entrada 3"];
    });
  }

  // Simulación de la función marcarFavorito()
  void marcarFavorito(int idEntrada) {
    print("Entrada $idEntrada marcada como favorita");
  }

  // Simulación de la función agregarEtiqueta()
  void agregarEtiqueta(int idEntrada, String etiqueta) {
    print("Etiqueta '$etiqueta' agregada a la entrada $idEntrada");
  }

  // Simulación de la función buscarPorEtiqueta()
  void buscarPorEtiqueta(String etiqueta) {
    print("Buscando entradas con la etiqueta: $etiqueta");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:Center(
          child: Text('Gestión de Favoritos',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: verFavoritos,
              child: Text("Ver Favoritos"),
            ),
            if (favoritos.isNotEmpty)
              ...favoritos.map((fav) => ListTile(title: Text(fav))).toList(),
            SizedBox(height: 20),
            TextField(
              controller: etiquetaController,
              decoration: InputDecoration(
                labelText: "Agregar etiqueta",
                hintText: "Ingresa etiqueta",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                agregarEtiqueta(1, etiquetaController.text);
                etiquetaController.clear();
              },
              child: Text("Agregar Etiqueta a Entrada 1"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: buscarEtiquetaController,
              decoration: InputDecoration(
                labelText: "Buscar por etiqueta",
                hintText: "Ingresa etiqueta",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                buscarPorEtiqueta(buscarEtiquetaController.text);
              },
              child: Text("Buscar"),
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
