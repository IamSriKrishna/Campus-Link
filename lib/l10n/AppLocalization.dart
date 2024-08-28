
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:campuslink/l10n/Intl/intl_All.dart';

class S {
    S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }
  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  //Good Morning
  String get goodMorning {
    return Intl.message(
      'Good Moring',
      name: 'goodMorning',
      desc: '',
      args: [],
    );
  }

  //Good Morning
  String get goodEvening {
    return Intl.message(
      'Good Evening',
      name: 'goodEvening',
      desc: '',
      args: [],
    );
  }
  
  //Good Afternoon
  String get goodAfternoon {
    return Intl.message(
      'Good Afternoon',
      name: 'goodAfternoon',
      desc: '',
      args: [],
    );
  }
    
  //homeScreenTitle
  String get homeScreenTitle {
    return Intl.message(
      'My Classes',
      name: 'homeScreenTitle',
      desc: '',
      args: [],
    );
  }

  String get onduty{
    return Intl.message(
      'On Duty',
      name: 'onduty',
      desc: '',
      args: [],
    );
  }

  String get leave{
    return Intl.message(
      'Leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  String get gatePass{
    return Intl.message(
      'Gate Pass',
      name: 'gatePass',
      desc: '',
      args: [],
    );
  }

  String get myClass{
    return Intl.message(
      'My Class',
      name: 'myClass',
      desc: '',
      args: [],
    );
  }
  
  String get credit{
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }
  
  String get notification{
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }
  
  String get myProfile{
    return Intl.message(
      'myProfile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }
  
  String get forgetPin{
    return Intl.message(
      'forgetPin',
      name: 'forgetPin',
      desc: '',
      args: [],
    );
  }
  
  String get language{
    return Intl.message(
      'language',
      name: 'language',
      desc: '',
      args: [],
    );
  }
  
  String get signOut{
    return Intl.message(
      'signOut',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }
  
  String get warningMessage{
    return Intl.message(
      'Warning Message',
      name: 'warningMessage',
      desc: '',
      args: [],
    );
  }
  
  String get ondutyDetails{
    return Intl.message(
      'Record your work hours efficiently',
      name: 'ondutyDetails',
      desc: '',
      args: [],
    );
  }
  
  String get leaveDetails{
    return Intl.message(
      'Request time off with ease',
      name: 'leaveDetails',
      desc: '',
      args: [],
    );
  }
  
  String get gatePassDetails{
    return Intl.message(
      'Authorize entry and exit',
      name: 'gatePassDetails',
      desc: '',
      args: [],
    );
  }
  
  String get from{
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }
  
  String get to{
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }
  
  String get today{
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }
  
  String get send{
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }
  
  String get reason{
    return Intl.message(
      'Reason',
      name: 'reason',
      desc: '',
      args: [],
    );
  }
  
  String get profile{
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }
  
  String get about{
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }
  
  String get approval{
    return Intl.message(
      'Approval',
      name: 'approval',
      desc: '',
      args: [],
    );
  }
  
  String get development{
    return Intl.message(
      'Development',
      name: 'development',
      desc: '',
      args: [],
    );
  }

  
  String get booking{
    return Intl.message(
      'Booking',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  String get credityouhave{
    return Intl.message(
      'credityouhave',
      name: 'credityouhave',
      desc: '',
      args: [],
    );
  } 

  
  String get percredit{
    return Intl.message(
      'percredit',
      name: 'percredit',
      desc: '',
      args: [],
    );
  }

  
  String get totaldaysselected{
    return Intl.message(
      'totaldaysselected',
      name: 'totaldaysselected',
      desc: '',
      args: [],
    );
  }

  
  String get totalcredit{
    return Intl.message(
      'totalcredit',
      name: 'totalcredit',
      desc: '',
      args: [],
    );
  }

  
  String get continues{
    return Intl.message(
      'continues',
      name: 'continues',
      desc: '',
      args: [],
    );
  }

  
  String get warning{
    return Intl.message(
      'warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  
  String get pleaseselectoneormoredaystocontinue{
    return Intl.message(
      'pleaseselectoneormoredaystocontinue',
      name: 'pleaseselectoneormoredaystocontinue',
      desc: '',
      args: [],
    );
  }

  
  String get ok{
    return Intl.message(
      'ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  
  String get kindlyrefillyourcredit{
    return Intl.message(
      'kindlyrefillyourcredit',
      name: 'kindlyrefillyourcredit',
      desc: '',
      args: [],
    );
  }

  
  String get name{
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  
  String get pleasedonotexitthispageyourcreditwillbelost{
    return Intl.message(
      'pleasedonotexitthispageyourcreditwillbelost',
      name: 'pleasedonotexitthispageyourcreditwillbelost',
      desc: '',
      args: [],
    );
  }

  
  String get cancel{
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  
  String get proceed{
    return Intl.message(
      'proceed',
      name: 'proceed',
      desc: '',
      args: [],
    );
  }

  
  String get rollnumber{
    return Intl.message(
      'rollnumber',
      name: 'rollnumber',
      desc: '',
      args: [],
    );
  }

  
  String get department{
    return Intl.message(
      'department',
      name: 'department',
      desc: '',
      args: [],
    );
  }

  
  String get noofday{
    return Intl.message(
      'noofday',
      name: 'noofday',
      desc: '',
      args: [],
    );
  }

  
  String get noofdays{
    return Intl.message(
      'noofdays',
      name: 'noofdays',
      desc: '',
      args: [],
    );
  }

  
  String get day{
    return Intl.message(
      'day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  
  String get days{
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  
  String get enteryourreason{
    return Intl.message(
      'enteryourreason',
      name: 'enteryourreason',
      desc: '',
      args: [],
    );
  }

  
  String get submit{
    return Intl.message(
      'submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  
  String get history{
    return Intl.message(
      'history',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  
  String get yes{
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  
  String get wanttoexitcampuslink{
    return Intl.message(
      'wanttoexitcampuslink',
      name: 'wanttoexitcampuslink',
      desc: '',
      args: [],
    );
  }

  
  String get no{
    return Intl.message(
      'no',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  
  String get totalspend{
    return Intl.message(
      'totalspend',
      name: 'totalspend',
      desc: '',
      args: [],
    );
  }

}



class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ta'),
      Locale.fromSubtags(languageCode: 'ml'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'te'),
      Locale.fromSubtags(languageCode: 'kn'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }}