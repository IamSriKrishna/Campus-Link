import 'package:campuslink/Feature/Screen/KCGAI/Keywords.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikchatbot/ikchatbot.dart';
import 'package:provider/provider.dart';

class KCGAI extends StatefulWidget {
  final String name;
  KCGAI({required this.name});
  @override
  State<KCGAI> createState() => _KCGAIState();
}

class _KCGAIState extends State<KCGAI> {
  void check() {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Instruction!!"),
          content: Text(S.current.development),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            )
          ],
        );
      },
    );
  }

  final chatBotConfig = IkChatBotConfig(
    useAsset: false,
    backgroundAssetimage: '',
    ratingIconYes: const Icon(Icons.star),
    ratingIconNo: const Icon(Icons.star_border),
    ratingIconColor: Colors.black,
    ratingBackgroundColor: Colors.white,
    ratingButtonText: 'Submit Rating',
    thankyouText: 'Thanks for your rating!',
    ratingText: 'Rate your experience:',
    ratingTitle: 'Thank you for using the chatbot!',
    body: 'This is a test email sent from Flutter and Dart.',
    subject: 'Test Rating',
    recipient: 'recipient@example.com',
    isSecure: false,
    senderName: 'Your Name',
    smtpUsername: 'Your Email',
    smtpPassword: 'your password',
    smtpServer: 'stmp.gmail.com',
    smtpPort: 587,
    sendIcon: const Icon(Icons.send, color: Colors.black),
    userIcon: const Icon(Icons.person, color: Colors.white),
    botIcon: const Icon(Icons.android, color: Colors.white),
    botChatColor: const Color.fromARGB(255, 81, 80, 80),
    delayBot: 100,
    closingTime: 1,
    delayResponse: 1,
    userChatColor: Colors.blue,
    waitingTime: 1,
    keywords: keywords,
    responses: responses,
    backgroundColor: Colors.white,
    backgroundImage: 'https://cdn.wallpapersafari.com/54/0/HluF7g.jpg',
    initialGreeting:
        "👋 Hello! \nWelcome to KCGPT\nHow can I assist you today?",
    defaultResponse:
        "Sorry, I didn't understand your response.\If any important type 'Help'",
    inactivityMessage: "Is there anything else you need help with?",
    closingMessage: "This conversation will now close.",
    inputHint: 'Send a message',
    waitingText: 'Please wait...',
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      check();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeMode.getDarkTheme ? themeColor.darkTheme : Colors.white,
        centerTitle: true,
        title: const Text('KCGPT'),
      ),
      body: ikchatbot(config: chatBotConfig),
    );
  }
}
