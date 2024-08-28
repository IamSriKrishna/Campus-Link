import 'package:sqflite/sqflite.dart' as sql;
class GatePassSQL{
  static Future<void> CreateTable(sql.Database database)async{
    await database.execute("""CREATE TABLE gatepass(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        [from] TEXT,
        [to] TEXT,
        reason TEXT
      )
      """
    );
  }

  static Future<sql.Database> DB()async{
    return sql.openDatabase(
      'gatepassHistory.db',
      version: 1,
      onCreate: (sql.Database db,int version) async{
        //print('....CREATING DATABASE');
        await CreateTable(db);
      },
    );
  }

  static Future<int> CreateItem(
    String date,
    String from,
    String to,
    String reason
  )async{
    final db = await GatePassSQL.DB();
    final data = {
      'date':date,
      'from':from,
      'to':to,
      'reason' :reason,
    };
    final id = await db.insert(
      'gatepass', 
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace
    );

    return id;
  }

  static Future<List<Map<String,dynamic>>> getItems()async{
    final db = await GatePassSQL.DB();
    return db.query(
      'gatepass',  
      orderBy: 'id'
    );
  }
}