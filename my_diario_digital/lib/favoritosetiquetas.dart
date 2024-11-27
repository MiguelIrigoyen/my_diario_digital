import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*void main() {
  runApp(MyApp());
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Favoritos y Etiquetas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FavoritosEtiquetasScreen(),
    );
  }
}

// Modelo para una entrada
class Entrada {
  final int id;
  final String titulo;
  final String contenido;
  final DateTime fechaCreacion;
  bool esFavorito;
  List<String> etiquetas;

  Entrada({
    required this.id,
    required this.titulo,
    required this.contenido,
    required this.fechaCreacion,
    this.esFavorito = false,
    this.etiquetas = const [],
  });
}

// Controlador para gestionar favoritos y etiquetas
class FavoritosEtiquetasController {
  late Database _db;

  Future<void> inicializarDB() async {
    String path = join(await getDatabasesPath(), 'favoritos_etiquetas.db');
    _db = await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(
            '''CREATE TABLE entradas (id INTEGER PRIMARY KEY, titulo TEXT, contenido TEXT, fechaCreacion TEXT, esFavorito INTEGER)''');
        db.execute(
            '''CREATE TABLE etiquetas (id INTEGER PRIMARY KEY, entradaId INTEGER, nombre TEXT, FOREIGN KEY (entradaId) REFERENCES entradas (id))''');
      },
      version: 1,
    );
  }

  Future<void> agregarEntrada(Entrada entrada) async {
    await _db.insert('entradas', {
      'id': entrada.id,
      'titulo': entrada.titulo,
      'contenido': entrada.contenido,
      'fechaCreacion': entrada.fechaCreacion.toIso8601String(),
      'esFavorito': entrada.esFavorito ? 1 : 0,
    });
  }

  Future<List<Entrada>> obtenerFavoritos() async {
    final data = await _db.query(
      'entradas',
      where: 'esFavorito = ?',
      whereArgs: [1],
      orderBy: 'fechaCreacion DESC',
    );

    return data
        .map((e) => Entrada(
              id: e['id'] as int,
              titulo: e['titulo'] as String,
              contenido: e['contenido'] as String,
              fechaCreacion: DateTime.parse(e['fechaCreacion'] as String),
              esFavorito: (e['esFavorito'] as int) == 1,
            ))
        .toList();
  }

  Future<void> marcarFavorito(int idEntrada) async {
    final entrada = await _db.query(
      'entradas',
      where: 'id = ?',
      whereArgs: [idEntrada],
    );

    if (entrada.isNotEmpty) {
      final esFavorito = (entrada.first['esFavorito'] as int) == 1;
      await _db.update(
        'entradas',
        {'esFavorito': esFavorito ? 0 : 1},
        where: 'id = ?',
        whereArgs: [idEntrada],
      );
    }
  }

  Future<void> agregarEtiqueta(int idEntrada, String etiqueta) async {
    await _db.insert('etiquetas', {
      'entradaId': idEntrada,
      'nombre': etiqueta.trim().toLowerCase(),
    });
  }

  Future<List<Entrada>> buscarPorEtiqueta(String etiqueta) async {
    final data = await _db.rawQuery(
        '''SELECT e.* FROM entradas e INNER JOIN etiquetas t ON e.id = t.entradaId WHERE t.nombre = ?''',
        [etiqueta.toLowerCase()]);

    return data
        .map((e) => Entrada(
              id: e['id'] as int,
              titulo: e['titulo'] as String,
              contenido: e['contenido'] as String,
              fechaCreacion: DateTime.parse(e['fechaCreacion'] as String),
              esFavorito: (e['esFavorito'] as int) == 1,
            ))
        .toList();
  }
}

// Pantalla principal
class FavoritosEtiquetasScreen extends StatefulWidget {
  @override
  _FavoritosEtiquetasScreenState createState() =>
      _FavoritosEtiquetasScreenState();
}

class _FavoritosEtiquetasScreenState extends State<FavoritosEtiquetasScreen> {
  final FavoritosEtiquetasController _controller =
      FavoritosEtiquetasController();
  List<Entrada> _favoritos = [];
  final TextEditingController _etiquetaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.inicializarDB().then((_) => _cargarFavoritos());
  }

  Future<void> _cargarFavoritos() async {
    final favoritos = await _controller.obtenerFavoritos();
    setState(() {
      _favoritos = favoritos;
    });
  }

  Future<void> _marcarFavorito(int id) async {
    await _controller.marcarFavorito(id);
    _cargarFavoritos();
  }

  Future<void> _buscarPorEtiqueta() async {
    final etiqueta = _etiquetaController.text.trim();
    if (etiqueta.isEmpty) return;

    final filtrados = await _controller.buscarPorEtiqueta(etiqueta);
    setState(() {
      _favoritos = filtrados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favoritos y Etiquetas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _etiquetaController,
                    decoration: InputDecoration(labelText: 'Buscar etiqueta'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _buscarPorEtiqueta,
                  child: Text('Buscar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _favoritos.length,
              itemBuilder: (context, index) {
                final entrada = _favoritos[index];
                return ListTile(
                  title: Text(entrada.titulo),
                  subtitle: Text(entrada.fechaCreacion.toIso8601String()),
                  trailing: IconButton(
                    icon: Icon(
                      entrada.esFavorito
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: entrada.esFavorito ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => _marcarFavorito(entrada.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
