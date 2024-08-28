import 'package:campuslink/model/chat/chat.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class ChatDatabaseHelper {
  static final ChatDatabaseHelper _instance = ChatDatabaseHelper._internal();
  factory ChatDatabaseHelper() => _instance;

  ChatDatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/chat.db';
    return await databaseFactoryIo.openDatabase(path);
  }

  Future<void> saveChatModel(ChatModel chatModel) async {
    final db = await database;
    final store = intMapStoreFactory.store('chats');
    await store.record(1).put(db, chatModel.toMap());
  }

  Future<ChatModel?> getChatModel() async {
    final db = await database;
    final store = intMapStoreFactory.store('chats');
    final record = await store.record(1).get(db);
    if (record != null) {
      return ChatModel.fromJson(record);
    }
    return null;
  }
}