import 'package:flutter/material.dart';

void main() => runApp(FavoritosApp());

class FavoritosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FavoritosScreen(),
    );
  }
}

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
        title: Text("Gestión de Favoritos"),
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
    );
  }
}
