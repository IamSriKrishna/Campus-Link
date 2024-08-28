
import 'package:intl/message_lookup_by_library.dart';

// Define the messages for Hindi locale
final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'hi'; // Define the locale for Hindi

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "goodMorning": MessageLookupByLibrary.simpleMessage("सुबह बखैर"),
    "goodAfternoon": MessageLookupByLibrary.simpleMessage("सुसंध्या"),
    "goodEvening": MessageLookupByLibrary.simpleMessage("शुभ संध्या"),
    "homeScreenTitle": MessageLookupByLibrary.simpleMessage("मेरी क्लासें"),
    "onduty": MessageLookupByLibrary.simpleMessage("ड्यूटी पर"),
    "leave": MessageLookupByLibrary.simpleMessage("अवकाश"),
    "gatePass": MessageLookupByLibrary.simpleMessage("गेट पास"),
    "myClass": MessageLookupByLibrary.simpleMessage("मेरी कक्षा"),
    "credit": MessageLookupByLibrary.simpleMessage("मूल्य"),
    "notification": MessageLookupByLibrary.simpleMessage("सूचना"),
    "myProfile": MessageLookupByLibrary.simpleMessage("मेरा प्रोफ़ाइल"),
    "forgetPin": MessageLookupByLibrary.simpleMessage("पिन भूल गए"), 
    "language": MessageLookupByLibrary.simpleMessage("भाषा"), 
    "signOut": MessageLookupByLibrary.simpleMessage("साइन आउट करें"), 
    "warningMessage": MessageLookupByLibrary.simpleMessage("आपका संदेश सिफारिश की न्यूनतम 5 शब्दों से काफी कम प्रतित होता है। कृपया स्पष्टता और प्रभावी संवाद सुनिश्चित करने के लिए और संदर्भ या जानकारी प्रदान करें।"),
    "ondutyDetails": MessageLookupByLibrary.simpleMessage("अपने काम के घंटों को कुशलतापूर्वक रिकॉर्ड करें"),
    "leaveDetails": MessageLookupByLibrary.simpleMessage("आराम से छुट्टी का अनुरोध करें"),
    "gatePassDetails": MessageLookupByLibrary.simpleMessage("प्रवेश और निकास को अधिकृत करें"),
    "from": MessageLookupByLibrary.simpleMessage("से"),
    "to": MessageLookupByLibrary.simpleMessage("तक"),
    "today": MessageLookupByLibrary.simpleMessage("आज"),
    "send": MessageLookupByLibrary.simpleMessage("भेजें"),
    "reason": MessageLookupByLibrary.simpleMessage("कारण"),
    "profile": MessageLookupByLibrary.simpleMessage("मेरे बारे में"),
    "about": MessageLookupByLibrary.simpleMessage("बारे में"),
    "approval": MessageLookupByLibrary.simpleMessage("अनुमोदन"),
    "development": MessageLookupByLibrary.simpleMessage("सुविधा विकास में है, सीमित कार्यक्षमता है, परीक्षण जारी है, आपकी प्रतिक्रिया को महत्व दिया गया है, कोई रिलीज़ तिथि निर्धारित नहीं है। समझने के लिए धन्यवाद।"),
    "booking": MessageLookupByLibrary.simpleMessage("बुकिंग"),
    "credityouhave": MessageLookupByLibrary.simpleMessage("आपके पास क्रेडिट है"),
    "percredit": MessageLookupByLibrary.simpleMessage("प्रति क्रेडिट"),
    "totaldaysselected": MessageLookupByLibrary.simpleMessage("कुल चयनित दिन"),
    "totalcredit": MessageLookupByLibrary.simpleMessage("कुल क्रेडिट"),
    "continues": MessageLookupByLibrary.simpleMessage("जारी रखें"),
    "warning": MessageLookupByLibrary.simpleMessage("चेतावनी!"),
    "pleaseselectoneormoredaystocontinue": MessageLookupByLibrary.simpleMessage("कृपया जारी रखने के लिए एक या एक से अधिक दिन चुनें"),
    "ok": MessageLookupByLibrary.simpleMessage("ठीक है"),
    "kindlyrefillyourcredit": MessageLookupByLibrary.simpleMessage("कृपया अपने क्रेडिट को फिर से भरें"),
    "name": MessageLookupByLibrary.simpleMessage("नाम"),
    "pleasedonotexitthispageyourcreditwillbelost": MessageLookupByLibrary.simpleMessage("कृपया इस पेज से बाहर न जाएं, आपका क्रेडिट खो जाएगा।"),
    "cancel": MessageLookupByLibrary.simpleMessage("रद्द करें"),
    "proceed": MessageLookupByLibrary.simpleMessage("आगे बढ़ें"),
    "rollnumber": MessageLookupByLibrary.simpleMessage("रोल नंबर"),
    "department": MessageLookupByLibrary.simpleMessage("विभाग"),
    "noofday": MessageLookupByLibrary.simpleMessage("दिनों की संख्या"),
    "noofdays": MessageLookupByLibrary.simpleMessage("दिनों की संख्या"),
    "day": MessageLookupByLibrary.simpleMessage("दिन"),
    "days": MessageLookupByLibrary.simpleMessage("दिन"),
    "enteryourreason": MessageLookupByLibrary.simpleMessage("अपना कारण दर्ज करें"),
    "submit": MessageLookupByLibrary.simpleMessage("सबमिट करें"),
    "history": MessageLookupByLibrary.simpleMessage("इतिहास"),
    "yes": MessageLookupByLibrary.simpleMessage("हां"),
    "wanttoexitcampuslink": MessageLookupByLibrary.simpleMessage("कैंपस-लिंक से बाहर निकलना चाहते हैं?"),
    "no": MessageLookupByLibrary.simpleMessage("नहीं"),
    "totalspend": MessageLookupByLibrary.simpleMessage("कुल व्यय"),
  
  };
}
