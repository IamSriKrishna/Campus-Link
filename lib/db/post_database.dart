import 'package:campuslink/model/post/post.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class PostDatabaseHelper {
  static final PostDatabaseHelper _instance = PostDatabaseHelper._internal();
  factory PostDatabaseHelper() => _instance;

  PostDatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/post.db';
    return await databaseFactoryIo.openDatabase(path);
  }

  Future<void> savePostModel(PostModel postModel) async {
    final db = await database;
    final store = intMapStoreFactory.store('posts');
    await store.record(1).put(db, postModel.toMap());
  }

  Future<PostModel?> getPostModel() async {
    final db = await database;
    final store = intMapStoreFactory.store('posts');
    final record = await store.record(1).get(db);
    if (record != null) {
      return PostModel.fromJson(record);
    }
    return null;
  }
}