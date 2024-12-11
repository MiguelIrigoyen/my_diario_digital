import "package:sqflite/sqflite.dart";
import "package:path/path.dart";
const path=null;
class BaseDeDatos {
  Future<Database> _openDataBase() async{
    final databasepath =await  getDatabasesPath();
    final path=join(databasepath,'mydatabase.db');
    return openDataBase(path, onCreate: (db,version) async{
        await db.execute(
              'CREATE TABLE mitabla (id integer primary key,name TEXT)',);
    },version: 1
    );
  }
Future<void> addData() async{
    final database =await openDatabase(path);
    await database.insert(
      'mitabla',
      {'name':'juan'},
      conflictAlgorithm:ConflictAlgorithm.replace,
    );
    await database.close();
}

}










