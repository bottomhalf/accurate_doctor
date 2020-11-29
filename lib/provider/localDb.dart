import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const UserDetailTable = 'userdetail';

class LocalDb {
  static final LocalDb _instance = new LocalDb.internal();

  factory LocalDb() => _instance;
  static Database _db;

  LocalDb.internal();

  Future<bool> initDb() async {
    //io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    var databasesPath = await getDatabasesPath();
    print('Database path: $databasesPath');
    String path = join(databasesPath, "accurate_doc.db");
    _db = await openDatabase(path, version: 1, onCreate: onCreate);
    /* dropTable('demo').then((value) {
      print('Table deleted: ${value}');
    });*/
    print('Db instance created...');
    return true;
  }

  Database get db {
    return _db;
  }

  Future<bool> deleteById(String tableName, int userId) async {
    bool flag = false;
    print('userId $userId');
    int recordDeleted =
        await _db.rawDelete("delete from $tableName where UserId = $userId");
    if (recordDeleted > 0) {
      print('Deleted user id: ${recordDeleted}');
      flag = true;
    } else {
      print('No record found for: $userId');
    }
    return flag;
  }

  Future<List<Map<String, dynamic>>> get(String tableName) async {
    var Result = await _db.query(tableName);
    print('Data: ${json.encode(Result)}');
    return Result;
  }

  Future<bool> isTableExists(String tableName) async {
    bool Flag = false;
    if (_db != null) {
      try {
        var result = await _db.rawQuery(
            '''SELECT name FROM sqlite_master WHERE type='table' AND name = '$tableName' ''');
        if (result.length > 0) Flag = true;
      } catch (e) {
        print('Error: $e');
      }
    } else {
      print('Database instance is null');
    }
    return Flag;
  }

  Future<int> dropTable(String tableName) {
    return _db.rawDelete('Drop table $tableName');
  }

  void onCreate(Database db, int version) async {
    // When creating the db, create the table
    String query = '''CREATE TABLE $UserDetailTable 
        (UserId INTEGER PRIMARY KEY,
        strFirstName varchar(100),
        strLastName varchar(100),
        strGender varchar(100),
        strDOB varchar(100),
        strMobileNo varchar(100),
        strEmail varchar(100),
        strExperience varchar(100),
        strImagePath varchar(100),
        strUserName varchar(100),
        intRoleId INTEGER,
        strTitle varchar(100),
        strMiddleName varchar(100),
        strAddress varchar(100),
        strZipCode varchar(100),
        HealthyGx_Unique_ID varchar(100))''';

    print('Query: $query');
    await db.execute(query).then((_) {
      print('Table created successfully');
    });
  }
}
