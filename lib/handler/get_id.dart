import 'package:get_storage/get_storage.dart';

class StorageUtil {
  static final GetStorage _prefs = GetStorage();

  static String getUserId() {
    final userId = _prefs.read<String>("userId");
    if (userId == null) {
      throw Exception('User ID not found');
    }
    return userId;
  }
}
