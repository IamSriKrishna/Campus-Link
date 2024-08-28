import 'package:campuslink/model/student/student.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class StudentDatabaseHelper {
  static final StudentDatabaseHelper _instance =
      StudentDatabaseHelper._internal();
  factory StudentDatabaseHelper() => _instance;

  StudentDatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/student.db';
    return await databaseFactoryIo.openDatabase(path);
  }

  Future<void> saveStudentModel(StudentModel studentModel) async {
    final db = await database;
    final store = intMapStoreFactory.store('students');
    await store.record(1).put(db, studentModel.toMap());
  }

  Future<StudentModel?> getStudentModel() async {
    final db = await database;
    final store = intMapStoreFactory.store('students');
    final record = await store.record(1).get(db);
    if (record != null) {
      return StudentModel.fromJson(record);
    }
    return null;
  }
}
