import 'package:intl/message_lookup_by_library.dart';

// Define the messages for English locale
final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "goodMorning": MessageLookupByLibrary.simpleMessage("Good Morning"),
    "goodAfternoon": MessageLookupByLibrary.simpleMessage("Good Afternoon"),
    "goodEvening": MessageLookupByLibrary.simpleMessage("Good Evening"),
    "homeScreenTitle": MessageLookupByLibrary.simpleMessage("My Classes"),
    "onduty": MessageLookupByLibrary.simpleMessage("On Duty"),
    "leave": MessageLookupByLibrary.simpleMessage("Leave"),
    "gatePass": MessageLookupByLibrary.simpleMessage("Gate Pass"),
    "myClass": MessageLookupByLibrary.simpleMessage("My Class"),
    "credit": MessageLookupByLibrary.simpleMessage("Credit"),
    "notification": MessageLookupByLibrary.simpleMessage("Notification"),
    "myProfile": MessageLookupByLibrary.simpleMessage("My Profile"),
    "forgetPin": MessageLookupByLibrary.simpleMessage("Forget Pin"), 
    "language": MessageLookupByLibrary.simpleMessage("Language"), 
    "signOut": MessageLookupByLibrary.simpleMessage("Sign Out"),
    "warningMessage": MessageLookupByLibrary.simpleMessage("Your message appears to be significantly shorter than the recommended minimum of 5 words. Please provide more context or information to ensure clarity and effective communication."),
    "ondutyDetails": MessageLookupByLibrary.simpleMessage("Record your work hours efficiently"),
    "leaveDetails": MessageLookupByLibrary.simpleMessage("Request time off with ease"),
    "gatePassDetails": MessageLookupByLibrary.simpleMessage("Authorize entry and exit"),
    "from": MessageLookupByLibrary.simpleMessage("From"),
    "to": MessageLookupByLibrary.simpleMessage("To"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "send": MessageLookupByLibrary.simpleMessage("Send"),
    "reason": MessageLookupByLibrary.simpleMessage("Reason"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "approval": MessageLookupByLibrary.simpleMessage("Approval"),
    "development": MessageLookupByLibrary.simpleMessage("Feature in development, limited functionality, testing ongoing, your feedback valued, no release date set. Thanks for understanding."),
    "booking": MessageLookupByLibrary.simpleMessage("Booking"),
    "credityouhave": MessageLookupByLibrary.simpleMessage("Credit You Have"),
    "percredit": MessageLookupByLibrary.simpleMessage("Per Credit"),
    "totaldaysselected": MessageLookupByLibrary.simpleMessage("Total days selected"),
    "totalcredit": MessageLookupByLibrary.simpleMessage("Total Credit"),
    "continues": MessageLookupByLibrary.simpleMessage("Continue"),
    "warning": MessageLookupByLibrary.simpleMessage("Warning!"),
    "pleaseselectoneormoredaystocontinue": MessageLookupByLibrary.simpleMessage("Please Select 1 or More days to continue"),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "kindlyrefillyourcredit": MessageLookupByLibrary.simpleMessage("Kindly Refill Your Credit"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "pleasedonotexitthispageyourcreditwillbelost": MessageLookupByLibrary.simpleMessage("Please do not exit this page\nYour credit will be lost."),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "proceed": MessageLookupByLibrary.simpleMessage("Proceed"),
    "rollnumber": MessageLookupByLibrary.simpleMessage("Roll Number"),
    "department": MessageLookupByLibrary.simpleMessage("Department"),
    "noofday": MessageLookupByLibrary.simpleMessage("No of Day"),
    "noofdays": MessageLookupByLibrary.simpleMessage("No of Days"),
    "day": MessageLookupByLibrary.simpleMessage("Day"),
    "days": MessageLookupByLibrary.simpleMessage("Days"),
    "enteryourreason": MessageLookupByLibrary.simpleMessage("Enter Your Reason"),
    "submit": MessageLookupByLibrary.simpleMessage("SUBMIT"),
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "yes": MessageLookupByLibrary.simpleMessage("Yes"),
    "wanttoexitcampuslink": MessageLookupByLibrary.simpleMessage("Want To Exit Campus~Link?"),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "totalspend": MessageLookupByLibrary.simpleMessage("Total Spend"),
  
  };
}
