
import 'package:intl/message_lookup_by_library.dart';

// Define the messages for Hindi locale
final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ta';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "goodMorning": MessageLookupByLibrary.simpleMessage("காலை வணக்கம்"),
    "goodAfternoon": MessageLookupByLibrary.simpleMessage("மதிய வணக்கம்"),
    "goodEvening": MessageLookupByLibrary.simpleMessage("மாலை வணக்கம்"),
    "homeScreenTitle": MessageLookupByLibrary.simpleMessage("என் வகுப்புகள்"),
    "onduty": MessageLookupByLibrary.simpleMessage("கடமையில்"),
    "leave": MessageLookupByLibrary.simpleMessage("விடுப்பு காலம்"),
    "gatePass": MessageLookupByLibrary.simpleMessage("வழுவாய் அனுமதி"),
    "myClass": MessageLookupByLibrary.simpleMessage("எனது வகுப்பு"),
    "credit": MessageLookupByLibrary.simpleMessage("மதிப்பு"),
    "notification": MessageLookupByLibrary.simpleMessage("அறிவிப்பு"),
    "myProfile": MessageLookupByLibrary.simpleMessage("என் சுயமை"),
    "forgetPin": MessageLookupByLibrary.simpleMessage("பின் மறந்தேன்"), 
    "language": MessageLookupByLibrary.simpleMessage("மொழி"), 
    "signOut": MessageLookupByLibrary.simpleMessage("வெளியேறு"),
    "warningMessage": MessageLookupByLibrary.simpleMessage("உங்கள் செய்திகள் 5 வார்த்தைகள் குறைந்த மினிமம் பரிசயமிக்கு அதிகமாக காணப்படுகின்றது. வெளிச்சம் அல்லாத அதிசயமாக செய்தியை வழங்க அல்லாத தகவல் வழங்க விரைவாக தட்டச்சு செய்க."),
    "ondutyDetails": MessageLookupByLibrary.simpleMessage("உங்கள் வேலை நேரத்தை திறம்பட பதிவு செய்யவும்"),
    "leaveDetails": MessageLookupByLibrary.simpleMessage("விரும்பிய நேரத்தை கேட்கவும்"),
    "gatePassDetails": MessageLookupByLibrary.simpleMessage("நுழைவதையும் வெளியேறுவதையும் அங்கீகரிக்கவும்"),
    "from": MessageLookupByLibrary.simpleMessage("இருந்து"),
    "to": MessageLookupByLibrary.simpleMessage("வரை"),
    "today": MessageLookupByLibrary.simpleMessage("இன்று"),
    "send": MessageLookupByLibrary.simpleMessage("அனுப்பு"),
    "reason": MessageLookupByLibrary.simpleMessage("காரணம்"),
    "profile": MessageLookupByLibrary.simpleMessage("என்னை பற்றி"),
    "about": MessageLookupByLibrary.simpleMessage("தகவல்"),
    "approval": MessageLookupByLibrary.simpleMessage("அங்கீகாரம்"),
    "development": MessageLookupByLibrary.simpleMessage("வளர்ச்சியில் அம்சம், வரையறுக்கப்பட்ட செயல்பாடு, சோதனை நடந்து கொண்டிருக்கிறது, உங்கள் கருத்து மதிப்பு, வெளியீட்டு தேதி அமைக்கப்படவில்லை. புரிதலுக்கு நன்றி."),
    "booking": MessageLookupByLibrary.simpleMessage("புதுப்பித்தல்"),
    "credityouhave": MessageLookupByLibrary.simpleMessage("உங்கள் கடமை"),
    "percredit": MessageLookupByLibrary.simpleMessage("ஒரு கடமைக்கு"),
    "totaldaysselected": MessageLookupByLibrary.simpleMessage("மொத்த நாட்கள் தேர்ந்தெடுக்கப்பட்டன"),
    "totalcredit": MessageLookupByLibrary.simpleMessage("மொத்த கடமை"),
    "continues": MessageLookupByLibrary.simpleMessage("தொடர்க"),
    "warning": MessageLookupByLibrary.simpleMessage("எச்சரிக்கை!"),
    "pleaseselectoneormoredaystocontinue": MessageLookupByLibrary.simpleMessage("தொடர ஒரு அல்லது அதிக நாட்களை தேர்ந்தெடுக்கவும்"),
    "ok": MessageLookupByLibrary.simpleMessage("சரி"),
    "kindlyrefillyourcredit": MessageLookupByLibrary.simpleMessage("உங்கள் கடமையை மீண்டும் நிர்வகிக்கவும்"),
    "name": MessageLookupByLibrary.simpleMessage("பெயர்"),
    "pleasedonotexitthispageyourcreditwillbelost": MessageLookupByLibrary.simpleMessage("இந்த பக்கத்தை விட்டு செல்ல விரும்பாதே\nஉங்கள் கடமை இழந்து செல்லும்."),
    "cancel": MessageLookupByLibrary.simpleMessage("ரத்து செய்க"),
    "proceed": MessageLookupByLibrary.simpleMessage("தொடர்க"),
    "rollnumber": MessageLookupByLibrary.simpleMessage("பருவப்பேறு எண்"),
    "department": MessageLookupByLibrary.simpleMessage("பிரிவு"),
    "noofday": MessageLookupByLibrary.simpleMessage("நாட்களின் எண்"),
    "noofdays": MessageLookupByLibrary.simpleMessage("நாட்களின் எண்"),
    "day": MessageLookupByLibrary.simpleMessage("நாள்"),
    "days": MessageLookupByLibrary.simpleMessage("நாட்கள்"),
    "enteryourreason": MessageLookupByLibrary.simpleMessage("உங்கள் காரணத்தை உள்ளிடவும்"),
    "submit": MessageLookupByLibrary.simpleMessage("சமர்ப்பிக்கவும்"),
    "history": MessageLookupByLibrary.simpleMessage("வரலாறு"),
    "yes": MessageLookupByLibrary.simpleMessage("ஆம்"),
    "wanttoexitcampuslink": MessageLookupByLibrary.simpleMessage("கேம்பஸ்~இண்டெக்ஸ் வெளியேற வேண்டுமா?"),
    "no": MessageLookupByLibrary.simpleMessage("இல்லை"),
    "totalspend": MessageLookupByLibrary.simpleMessage("மொத்த செலவு"),
  
  };
}
