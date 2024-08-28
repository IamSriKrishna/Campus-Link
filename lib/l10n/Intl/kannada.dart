
import 'package:intl/message_lookup_by_library.dart';

// Define the messages for Kannada locale
final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'kn'; // 'kn' represents the Kannada locale

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "goodMorning": MessageLookupByLibrary.simpleMessage("ಶುಭೋದಯ"),
    "goodAfternoon": MessageLookupByLibrary.simpleMessage("ಶುಭ ಮಧ್ಯಾಹ್ನ"),
    "goodEvening": MessageLookupByLibrary.simpleMessage("ಶುಭ ಸಂಜೆ"),
    "homeScreenTitle": MessageLookupByLibrary.simpleMessage("ನನ್ನ ವಿದ್ಯಾನಿಲಯಗಳು"),
    "onduty": MessageLookupByLibrary.simpleMessage("ಕರ್ತವ್ಯದಲ್ಲಿ"),
    "leave": MessageLookupByLibrary.simpleMessage("ರಜೆ"),
    "gatePass": MessageLookupByLibrary.simpleMessage("ಗೇಟ್ ಪಾಸ್"),
    "myClass": MessageLookupByLibrary.simpleMessage("ನನ್ನ ವಿದ್ಯಾನಿಲಯ"),
    "credit": MessageLookupByLibrary.simpleMessage("ಕ್ರೆಡಿಟ್"),
    "notification": MessageLookupByLibrary.simpleMessage("ಅಧಿಸೂಚನೆ"),
    "myProfile": MessageLookupByLibrary.simpleMessage("ನನ್ನ ಪ್ರೊಫೈಲು"),
    "forgetPin": MessageLookupByLibrary.simpleMessage("ಪಿನ್ ಮರೆಯಲಾಗಿದೆ"),
    "language": MessageLookupByLibrary.simpleMessage("ಭಾಷೆ"),
    "signOut": MessageLookupByLibrary.simpleMessage("ಅಪಕ್ಷಮಾನ ಮಾಡಿ"),
    "warningMessage": MessageLookupByLibrary.simpleMessage("ನಿಮ್ಮ ಸಂದೇಶ ಸೂಚಿಸಲಾದ ಸೂಚನೆಗಳ ಕೆಳಮೊದಲಿನ ಮಿನಿಮಮ್ ಗಿರಿಕರಣಕ್ಕಿಂತ ಹೆಚ್ಚು ಚೊಕ್ಕಟವಾಗಿದೆ. ಸ್ಪಷ್ಟತೆ ಮತ್ತು ಪರಿಣಾಮಕಾರಕ ಆಚರಣೆಗೆ ಖಂಡಿತವಾಗಿ ಸಹಯೋಗಿಸಲು ಹೆಚ್ಚು ಸಂದರ್ಭ ಅಥವಾ ಮಾಹಿತಿ ನೀಡಲು ದಯವಿಟ್ಟು ನಿರೀಕ್ಷಣೆ ನೀಡಿ."),
    "ondutyDetails": MessageLookupByLibrary.simpleMessage("ನಿಮ್ಮ ಕೆಲಸದ ಗಂಟೆಗಳನ್ನು ಸಾರ್ಥಕವಾಗಿ ಗುರುತಿಸಿ"),
    "leaveDetails": MessageLookupByLibrary.simpleMessage("ಸುಲಭವಾಗಿ ರಜೆಯನ್ನು ಅನುರೋಧಿಸಿ"),
    "gatePassDetails": MessageLookupByLibrary.simpleMessage("ಪ್ರವೇಶ ಮತ್ತು ನಿಷ್ಕ್ರಮಣವನ್ನು ಅನುಮತಿಸಿ"),
    "from": MessageLookupByLibrary.simpleMessage("ನಿಂದ"),
    "to": MessageLookupByLibrary.simpleMessage("ಗೆರೆಯಲೋ"),
    "today": MessageLookupByLibrary.simpleMessage("ಇಂದು"),
    "send": MessageLookupByLibrary.simpleMessage("ಕಳುಹಿಸು"),
    "reason": MessageLookupByLibrary.simpleMessage("ಕಾರಣ"),
    "profile": MessageLookupByLibrary.simpleMessage("ಪ್ರೊಫೈಲು"),
    "about": MessageLookupByLibrary.simpleMessage("ಬಗ್ಗೆ"),
    "approval": MessageLookupByLibrary.simpleMessage("ಅನುಮೋದನೆ"),
    "development": MessageLookupByLibrary.simpleMessage("ಅಭಿವೃದ್ಧಿಯಲ್ಲಿ ವೈಶಿಷ್ಟ್ಯ, ಸೀಮಿತ ಕಾರ್ಯನಿರ್ವಹಣೆ, ಪರೀಕ್ಷೆ ನಡೆಯುತ್ತಿದೆ, ನಿಮ್ಮ ಪ್ರತಿಕ್ರಿಯೆ ಮೌಲ್ಯಯುತವಾಗಿದೆ, ಯಾವುದೇ ಬಿಡುಗಡೆ ದಿನಾಂಕವನ್ನು ಹೊಂದಿಸಲಾಗಿಲ್ಲ. ಅರ್ಥ ಮಾಡಿಕೊಂಡಿದ್ದಕ್ಕೆ ಧನ್ಯವಾದಗಳು."),
    "booking": MessageLookupByLibrary.simpleMessage("ಬುಕಿಂಗ್"),
    "credityouhave": MessageLookupByLibrary.simpleMessage("ನಿಮ್ಮ ಬುಕಿಂಗ್ ಸಾಲ"),
    "percredit": MessageLookupByLibrary.simpleMessage("ಪ್ರತಿ ಬುಕಿಂಗ್"),
    "totaldaysselected": MessageLookupByLibrary.simpleMessage("ಆಯ್ಕೆಮಾಡಿದ ದಿನಗಳ ಮೊತ್ತ"),
    "totalcredit": MessageLookupByLibrary.simpleMessage("ಒಟ್ಟು ಬುಕಿಂಗ್"),
    "continues": MessageLookupByLibrary.simpleMessage("ಮುಂದುವರಿಸಿ"),
    "warning": MessageLookupByLibrary.simpleMessage("ಎಚ್ಚರಿಕೆ!"),
    "pleaseselectoneormoredaystocontinue": MessageLookupByLibrary.simpleMessage("ಮುಂದುವರಿಸಲು ದಯವಿಟ್ಟು ಒಂದು ಅಥವಾ ಹೆಚ್ಚಿನ ದಿನಗಳನ್ನು ಆಯ್ಕೆಮಾಡಿ"),
    "ok": MessageLookupByLibrary.simpleMessage("ಸರಿ"),
    "kindlyrefillyourcredit": MessageLookupByLibrary.simpleMessage("ದಯವಿಟ್ಟು ನಿಮ್ಮ ಬುಕಿಂಗ್ ಸಾಲವನ್ನು ಮತ್ತೊಮ್ಮೆ ನೆರವೇರಿಸಿ"),
    "name": MessageLookupByLibrary.simpleMessage("ಹೆಸರು"),
    "pleasedonotexitthispageyourcreditwillbelost": MessageLookupByLibrary.simpleMessage("ಈ ಪುಟವನ್ನು ಬಿಟ್ಟು ಹೋಗಬೇಡಿ\nನಿಮ್ಮ ಬುಕಿಂಗ್ ಸಾಲ ಕಳೆದುಹೋಗುತ್ತದೆ."),
    "cancel": MessageLookupByLibrary.simpleMessage("ರದ್ದುಮಾಡಿ"),
    "proceed": MessageLookupByLibrary.simpleMessage("ಮುಂದುವರಿಸಿ"),
    "rollnumber": MessageLookupByLibrary.simpleMessage("ರೋಲ್ ಸಂಖ್ಯೆ"),
    "department": MessageLookupByLibrary.simpleMessage("ವಿಭಾಗ"),
    "noofday": MessageLookupByLibrary.simpleMessage("ದಿನಗಳ ಸಂಖ್ಯೆ"),
    "noofdays": MessageLookupByLibrary.simpleMessage("ದಿನಗಳ ಸಂಖ್ಯೆ"),
    "day": MessageLookupByLibrary.simpleMessage("ದಿನ"),
    "days": MessageLookupByLibrary.simpleMessage("ದಿನಗಳು"),
    "enteryourreason": MessageLookupByLibrary.simpleMessage("ನಿಮ್ಮ ಕಾರಣವನ್ನು ನಮೋದಿಸಿ"),
    "submit": MessageLookupByLibrary.simpleMessage("ಸಲ್ಲಿಸಿ"),
    "history": MessageLookupByLibrary.simpleMessage("ಇತಿಹಾಸ"),
    "yes": MessageLookupByLibrary.simpleMessage("ಹೌದು"),
    "wanttoexitcampuslink": MessageLookupByLibrary.simpleMessage("ಕ್ಯಾಂಪಸ್-ಲಿಂಕ್‌ನಿಂದ ನಿರ್ಗಮಿಸಲು ಬಯಸುವಿರಾ?"),
    "no": MessageLookupByLibrary.simpleMessage("ಇಲ್ಲ"),
    "totalspend": MessageLookupByLibrary.simpleMessage("ಒಟ್ಟು ಖರ್ಚು"),
  
  };
}
