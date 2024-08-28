import 'package:campuslink/model/message/message.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class MessageDatabaseHelper {
  static final MessageDatabaseHelper _instance = MessageDatabaseHelper._internal();
  factory MessageDatabaseHelper() => _instance;

  MessageDatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/message.db';
    return await databaseFactoryIo.openDatabase(path);
  }

  Future<void> saveMessageModel(MessageModel messageModel) async {
    final db = await database;
    final store = intMapStoreFactory.store('messages');
    await store.record(1).put(db, messageModel.toMap());
  }

  Future<MessageModel?> getMessageModel() async {
    final db = await database;
    final store = intMapStoreFactory.store('messages');
    final record = await store.record(1).get(db);
    if (record != null) {
      return MessageModel.fromJson(record);
    }
    return null;
  }
}