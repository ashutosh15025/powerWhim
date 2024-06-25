
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService{
  static Database ? _db;
  static final DatabaseService instance = DatabaseService._constructor();
  DatabaseService._constructor();

  final String _user = "User";
  final String  _userTableCId = "id";
  final String _userCUserId = "user_id";




  Future<Database> get database async{
       if(_db!=null)
         return _db!;
      _db =await getDatabase();
      return _db!;
  }


  Future<Database> getDatabase() async {

    final databaseDirPath = await getDatabasesPath();

    final databasePath = join(databaseDirPath, 'powerWhim.db');

    final database = await openDatabase(databasePath, version: 1,

        onCreate: (Database db, int version) async {

          await db.execute('''

        CREATE TABLE $_user (

          $_userTableCId INTEGER PRIMARY KEY AUTOINCREMENT,

          $_userCUserId TEXT NOT NULL

        )

      ''');

        });

    return database;

  }


  void addDetails(String userId)async{
    final db= await database;
    await db.insert(_user, {
      _userCUserId : userId
    });
  }


  Future<String?> getDetail() async{
    final db= await database;
    final data = await db.query(_user);
    if(data.length>0&&data[0]['user_id']!=null)
    return data[0]['user_id'].toString();
    else return null;
  }


  Future<int> delete(String id) async {
    final db= await database;
    return await db.delete(_user, where: '$_userCUserId = ?', whereArgs: [id]);
  }
}