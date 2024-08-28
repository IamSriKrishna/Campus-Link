
import 'package:intl/message_lookup_by_library.dart';

// Define the messages for Telugu locale
final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'te'; // 'te' represents the Telugu locale

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "goodMorning": MessageLookupByLibrary.simpleMessage("శుభోదయం"),
    "goodAfternoon": MessageLookupByLibrary.simpleMessage("శుభ మధ్యాహ్నం"),
    "goodEvening": MessageLookupByLibrary.simpleMessage("శుభ సాయంకాలం"),
    "homeScreenTitle": MessageLookupByLibrary.simpleMessage("నా విద్యలయాలు"),
    "onduty": MessageLookupByLibrary.simpleMessage("డ్యూటీలో"),
    "leave": MessageLookupByLibrary.simpleMessage("విరమణ"),
    "gatePass": MessageLookupByLibrary.simpleMessage("గేట్ పాస్"),
    "myClass": MessageLookupByLibrary.simpleMessage("నాకు విద్యానికి"),
    "credit": MessageLookupByLibrary.simpleMessage("క్రెడిట్"),
    "notification": MessageLookupByLibrary.simpleMessage("నోటిఫికేషన్"),
    "myProfile": MessageLookupByLibrary.simpleMessage("నా ప్రొఫైలు"),
    "forgetPin": MessageLookupByLibrary.simpleMessage("పిన్ మర్చిపోయాక"),
    "language": MessageLookupByLibrary.simpleMessage("భాష"),
    "signOut": MessageLookupByLibrary.simpleMessage("సైన్ అవుట్"),
    "warningMessage": MessageLookupByLibrary.simpleMessage("మీ సందేశం సూచించబడిన 5 అక్షరాల సరళ సూచనకి అతికిన చలువు ఉంది. స్పష్టత మరియు ప్రభావకారక కమ్యూనికేషన్ కోసం దయచేసి అదనంతా సందర్భానికి లేదా సమాచారం అందించడానికి మరియు సమగ్రత అదనంతా అధికము ఇవ్వడానికి దయచేసి సూచన లేదా సమాచారం అందించండి."),
    "ondutyDetails": MessageLookupByLibrary.simpleMessage("మీ పని గడుగుడిగా రికార్డ్ చేయండి"),
    "leaveDetails": MessageLookupByLibrary.simpleMessage("సులభతగా విరమణ అభ్యర్ధించండి"),
    "gatePassDetails": MessageLookupByLibrary.simpleMessage("ప్రవేశం మరియు ప్రస్థానం అనుమతించండి"),
    "from": MessageLookupByLibrary.simpleMessage("నుండి"),
    "to": MessageLookupByLibrary.simpleMessage("నికటంలో"),
    "today": MessageLookupByLibrary.simpleMessage("ఈ రోజు"),
    "send": MessageLookupByLibrary.simpleMessage("పంపండి"),
    "reason": MessageLookupByLibrary.simpleMessage("కారణం"),
    "profile": MessageLookupByLibrary.simpleMessage("ప్రొఫైలు"),
    "about": MessageLookupByLibrary.simpleMessage("గురించి"),
    "approval": MessageLookupByLibrary.simpleMessage("ఆమోదం"),
    "development": MessageLookupByLibrary.simpleMessage("డెవలప్‌మెంట్‌లో ఫీచర్, పరిమిత కార్యాచరణ, టెస్టింగ్ కొనసాగుతున్నది, మీ అభిప్రాయం విలువైనది, విడుదల తేదీ సెట్ చేయబడలేదు. అర్థం చేసుకున్నందుకు ధన్యవాదాలు."),
    "booking": MessageLookupByLibrary.simpleMessage("బుకింగ్"),
    "credityouhave": MessageLookupByLibrary.simpleMessage("మీకు ఉన్న క్రెడిట్"),
    "percredit": MessageLookupByLibrary.simpleMessage("ప్రతి క్రెడిట్"),
    "totaldaysselected": MessageLookupByLibrary.simpleMessage("ఎంచుకొన్న మొత్తం రోజులు"),
    "totalcredit": MessageLookupByLibrary.simpleMessage("మొత్తం క్రెడిట్"),
    "continues": MessageLookupByLibrary.simpleMessage("కొనసాగండి"),
    "warning": MessageLookupByLibrary.simpleMessage("హెచ్చరిక!"),
    "pleaseselectoneormoredaystocontinue": MessageLookupByLibrary.simpleMessage("కొనసాగడానికి దయచేసి ఒక లేదా ఎక్కువ రోజులను ఎంచుకోండి"),
    "ok": MessageLookupByLibrary.simpleMessage("సరే"),
    "kindlyrefillyourcredit": MessageLookupByLibrary.simpleMessage("మీ క్రెడిట్ మళ్లీ నింపండి"),
    "name": MessageLookupByLibrary.simpleMessage("పేరు"),
    "pleasedonotexitthispageyourcreditwillbelost": MessageLookupByLibrary.simpleMessage("దయచేసి ఈ పేజీ నుండి వెళితే\nమీ క్రెడిట్ కోలుంటుంది."),
    "cancel": MessageLookupByLibrary.simpleMessage("రద్దు చేయండి"),
    "proceed": MessageLookupByLibrary.simpleMessage("కొనసాగండి"),
    "rollnumber": MessageLookupByLibrary.simpleMessage("రోల్ నంబర్"),
    "department": MessageLookupByLibrary.simpleMessage("శాఖ"),
    "noofday": MessageLookupByLibrary.simpleMessage("రోజుల సంఖ్య"),
    "noofdays": MessageLookupByLibrary.simpleMessage("రోజుల సంఖ్య"),
    "day": MessageLookupByLibrary.simpleMessage("రోజు"),
    "days": MessageLookupByLibrary.simpleMessage("రోజులు"),
    "enteryourreason": MessageLookupByLibrary.simpleMessage("మీ కారణాన్ను నమోదు చేయండి"),
    "submit": MessageLookupByLibrary.simpleMessage("సమర్పించండి"),
    "history": MessageLookupByLibrary.simpleMessage("చరిత్ర"),
    "yes": MessageLookupByLibrary.simpleMessage("అవును"),
    "wanttoexitcampuslink": MessageLookupByLibrary.simpleMessage("క్యాంపస్-లింక్ నుండి నిష్క్రమించాలనుకుంటున్నారా?"),
    "no": MessageLookupByLibrary.simpleMessage("లేదు"),
    "totalspend": MessageLookupByLibrary.simpleMessage("మొత్తం ఖర్చు"),
  
  };
}
