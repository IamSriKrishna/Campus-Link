
import 'package:intl/message_lookup_by_library.dart';

// Define the messages for Malayalam locale
final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ml'; 

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "goodMorning": MessageLookupByLibrary.simpleMessage("സുപ്രഭാതം"),
    "goodAfternoon": MessageLookupByLibrary.simpleMessage("സന്ധ്യാദർശനം"),
    "goodEvening": MessageLookupByLibrary.simpleMessage("ശുഭ സന്ധ്യ"),
    "homeScreenTitle": MessageLookupByLibrary.simpleMessage("എന്റെ ക്ലാസുകൾ"),
    "onduty": MessageLookupByLibrary.simpleMessage("ഡ്യൂട്ടിയില്"),
    "leave": MessageLookupByLibrary.simpleMessage("അവസരം"),
    "gatePass": MessageLookupByLibrary.simpleMessage("ഗേറ്റ് പാസ്"),
    "myClass": MessageLookupByLibrary.simpleMessage("എന്റെ ക്ലാസ്"),
    "credit": MessageLookupByLibrary.simpleMessage("മൂല്യം"),
    "notification": MessageLookupByLibrary.simpleMessage("അറിയിപ്പ്"),
    "myProfile": MessageLookupByLibrary.simpleMessage("എനറെ പ്രൊഫൈൽ"), 
    "forgetPin": MessageLookupByLibrary.simpleMessage("പിൻ മറന്നില്ല"),
    "language": MessageLookupByLibrary.simpleMessage("ഭാഷ"),
    "signOut": MessageLookupByLibrary.simpleMessage("സൈൻ ഔട്ട്"),
    "warningMessage": MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ സന്ദേശം 5 വാക്കുകൾക്ക് പ്രതിശ്രദ്ധപ്പെടുന്ന നിശ്ചയമുള്ള അതിന്നു കുറച്ചു കൂടി സന്ദേശം നൽകുക. സ്പयाद സ്പयादന് തുടങ്ങി"),
    "ondutyDetails": MessageLookupByLibrary.simpleMessage("നിങ്ങളുടെ ജോലി സമയം കാര്യക്ഷമമായി രേഖപ്പെടുത്തുക"),
    "leaveDetails": MessageLookupByLibrary.simpleMessage("അനായാസം സമയം അഭ്യർത്ഥിക്കുക"),
    "gatePassDetails": MessageLookupByLibrary.simpleMessage("പ്രവേശനവും പുറത്തുകടക്കലും അംഗീകരിക്കുക"),
    "from": MessageLookupByLibrary.simpleMessage("മുതൽ"),
    "to": MessageLookupByLibrary.simpleMessage("വരെ"),
    "today": MessageLookupByLibrary.simpleMessage("ഇന്ന്"),
    "send": MessageLookupByLibrary.simpleMessage("അയച്ചിട്ടുക"),
    "reason": MessageLookupByLibrary.simpleMessage("കാരണം"),
    "profile": MessageLookupByLibrary.simpleMessage("പ്രൊഫൈൽ"),
    "about": MessageLookupByLibrary.simpleMessage("കുറിച്ച്"),
    "approval": MessageLookupByLibrary.simpleMessage("അംഗീകരിക്കല്"),
    "development": MessageLookupByLibrary.simpleMessage("വികസനത്തിലെ ഫീച്ചർ, പരിമിതമായ പ്രവർത്തനക്ഷമത, പരിശോധന തുടരുന്നു, നിങ്ങളുടെ ഫീഡ്‌ബാക്ക് വിലമതിക്കുന്നു, റിലീസ് തീയതി നിശ്ചയിച്ചിട്ടില്ല. മനസ്സിലാക്കിയതിനു നന്ദി"),"booking": MessageLookupByLibrary.simpleMessage("ബുക്കിങ്"),
    "credityouhave": MessageLookupByLibrary.simpleMessage("നിന്നെത്തുന്ന ക്രെഡിറ്റ്"),
    "percredit": MessageLookupByLibrary.simpleMessage("ഒരു ക്രെഡിറ്റിന്"),
    "totaldaysselected": MessageLookupByLibrary.simpleMessage("മൊത്ത ദിവസങ്ങൾ തിരഞ്ഞെടുക്കുക"),
    "totalcredit": MessageLookupByLibrary.simpleMessage("മൊത്ത ക്രെഡിറ്റ്"),
    "continues": MessageLookupByLibrary.simpleMessage("തുടരുക"),
    "warning": MessageLookupByLibrary.simpleMessage("മുന്നറിയിപ്പ്!"),
    "pleaseselectoneormoredaystocontinue": MessageLookupByLibrary.simpleMessage("തുടരാൻ ദിവസം ഒന്നേയും അല്ലെങ്കിൽ അധികം തിരഞ്ഞെടുക്കുക"),
    "ok": MessageLookupByLibrary.simpleMessage("ശരി"),
    "kindlyrefillyourcredit": MessageLookupByLibrary.simpleMessage("നിന്നെത്തുന്ന ക്രെഡിറ്റ് പുനഃപ്രവർത്തിപ്പിക്കുക"),
    "name": MessageLookupByLibrary.simpleMessage("പേര്"),
    "pleasedonotexitthispageyourcreditwillbelost": MessageLookupByLibrary.simpleMessage("ദയവായി ഈ പേജ് പൊക്കരുതേ\nനിന്നെത്തുന്ന ക്രെഡിറ്റ് നഷ്ടപ്പെടും."),
    "cancel": MessageLookupByLibrary.simpleMessage("റദ്ദാക്കുക"),
    "proceed": MessageLookupByLibrary.simpleMessage("മുന്നോട്ടുക"),
    "rollnumber": MessageLookupByLibrary.simpleMessage("റോൾ നമ്പർ"),
    "department": MessageLookupByLibrary.simpleMessage("വകുപ്പ്"),
    "noofday": MessageLookupByLibrary.simpleMessage("ദിവസങ്ങളുടെ എണ്ണം"),
    "noofdays": MessageLookupByLibrary.simpleMessage("ദിവസങ്ങളുടെ എണ്ണം"),
    "day": MessageLookupByLibrary.simpleMessage("ദിവസം"),
    "days": MessageLookupByLibrary.simpleMessage("ദിവസങ്ങൾ"),
    "enteryourreason": MessageLookupByLibrary.simpleMessage("നിന്നെത്തുന്ന കാരണം നൽകുക"),
    "submit": MessageLookupByLibrary.simpleMessage("സമർപ്പിക്കുക"),
    "history": MessageLookupByLibrary.simpleMessage("ചരിത്രം"),
    "yes": MessageLookupByLibrary.simpleMessage("അതെ"),
    "wanttoexitcampuslink": MessageLookupByLibrary.simpleMessage("കാമ്പസ്-ലിങ്കിൽ നിന്ന് പുറത്തുകടക്കാൻ ആഗ്രഹിക്കുന്നുണ്ടോ?"),
    "no": MessageLookupByLibrary.simpleMessage("ഇല്ല"),
    "totalspend": MessageLookupByLibrary.simpleMessage("ആകെ ചെലവ്"),
  
  };
}
