import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('media.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE media_files (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        file_path TEXT NOT NULL,
        type TEXT NOT NULL,
        category TEXT,
        note TEXT
      )
    ''');
  }

  Future<void> insertMediaFile(Map<String, dynamic> mediaFile) async {
    final db = await database;
    await db.insert('media_files', mediaFile, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllMediaFiles() async {
    final db = await database;
    return await db.query('media_files');
  }
  //Exportacion y copia de seguridad
  Future<void> exportData(String exportPath) async {
    final db = await database;
    final mediaFiles = await db.query('media_files');
    final jsonString = jsonEncode(mediaFiles);

    final file = File(exportPath);
    await file.writeAsString(jsonString);

    print('Datos exportados a: $exportPath');
  }

  Future<void> backupData() async {
    final directory = await getApplicationDocumentsDirectory();
    final backupPath = '${directory.path}/media_backup.json';

    await exportData(backupPath);
    print('Copia de seguridad guardada en: $backupPath');
  }

  Future<void> restoreData(String backupPath) async {
    final file = File(backupPath);

    if (await file.exists()) {
      final jsonString = await file.readAsString();
      final List<dynamic> mediaFiles = jsonDecode(jsonString);

      final db = await database;
      await db.delete('media_files'); // Limpiar la tabla actual antes de restaurar

      for (final mediaFile in mediaFiles) {
        await db.insert('media_files', mediaFile as Map<String, dynamic>);
      }

      print('Datos restaurados desde: $backupPath');
    } else {
      print('Archivo de respaldo no encontrado.');
    }
  }
}

