import 'package:campuslink/app/app_list.dart';

class PasswordMessageHandler {
  static final List<String> _shuffledMessages =
      List.from(AppList.passwordMessages);
  static int _currentIndex = 0;

  static String getNextMessage() {
    if (_currentIndex >= _shuffledMessages.length) {
      _shuffledMessages.shuffle();
      _currentIndex = 0;
    }
    return _shuffledMessages[_currentIndex++];
  }
}
