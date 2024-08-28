import 'package:campuslink/model/student/student.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class ProfileDatabaseHelper {
  static final ProfileDatabaseHelper _instance =
      ProfileDatabaseHelper._internal();
  factory ProfileDatabaseHelper() => _instance;

  ProfileDatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/profile.db';
    return await databaseFactoryIo.openDatabase(path);
  }

  Future<void> saveProfileModel(Student student) async {
    final db = await database;
    final store = intMapStoreFactory.store("profile");
    await store.record(1).put(db, student.toMap());
  }

  Future<Student?> getProfileModel() async {
    final db = await database;
    final store = intMapStoreFactory.store("profile");
    final record = await store.record(1).get(db);
    if (record != null) {
      return Student.fromJson(record);
    }
    return null;
  }
}
