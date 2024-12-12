import "package:sqflite/sqflite.dart";
import "package:path/path.dart";
const path=null;
class BaseDeDatos {
  Future<Database> _openDataBase() async{
    final databasepath =await  getDatabasesPath();
     path=join(databasepath,'mydatabase.db');
    return openDataBase(path, onCreate: (db,version) async{
        await db.execute(
              'CREATE TABLE mitabla (id integer primary key,name TEXT)',);
    },version: 1
    );
  }
Future<void> addData() async{
    final database =await _openDataBase();
    await database.insert(
      'mitabla',
      {'name':'juan'},
      conflictAlgorithm:ConflictAlgorithm.replace,
    );
    print('agregado');
    await database.close();
}
  Future<void> mostrar() async{
    final database =await _openDataBase();
    final data=await database.query('mitabla');
    print(data);
    await database.close();
  }
}










