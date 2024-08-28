import 'dart:convert';
import 'package:campuslink/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:campuslink/Feature/Screen/Payment/PaymentDone.dart';
import 'package:campuslink/Feature/Screen/Payment/PaymentFailed.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';
class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  FlutterTts ftts = FlutterTts();
  final TextEditingController credit = TextEditingController();
  String last = "";
  Future<void> sendCredit(
      String senderId, String receiverId, int credit) async {
    final student = Provider.of<StudentProvider>(context, listen: false).user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    String url = '${uri}/students/send-credit';
    String authToken = token!;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'x-auth-token': authToken,
    };

    Map<String, dynamic> requestBody = {
      "studentId": senderId,
      "receiverId": receiverId,
      "credit": credit
    };

    try {
      if (student.credit <= 0 || credit > student.credit) {
        Get.to(
            () => PaymentFailed(
                  creditSpent: credit,
                  receiverId: receiverId,
                ),
            transition: Transition.fadeIn,
            duration: Duration(milliseconds: 700));
      } else {
        var response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          print('POST request successful');
          Get.to(
              () => PaymentDone(
                    creditSpent: credit,
                    receiverId: receiverId,
                  ),
              transition: Transition.fadeIn,
              duration: Duration(milliseconds: 700));
        } else {
          Get.off(() => OverScreen());
        }
      }
    } catch (error) {
      print('Error sending POST request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentProvider>(context).user;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("KCG PAY"),
        foregroundColor: Colors.white,
        backgroundColor:
            theme.getDarkTheme ? null : Color.fromARGB(255, 25, 120, 184),
        actions: [
          IconButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title:
                        Text("My QR Code", style: GoogleFonts.merriweather()),
                    content: Container(
                      alignment: Alignment.center,
                      width: 200, // Adjust the width according to your needs
                      height: 200, // Adjust the height according to your needs
                      child: QrImageView(
                        data: student.id,
                        version: QrVersions.auto,
                      ),
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.qr_code,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor:
          theme.getDarkTheme ? null : Color.fromARGB(255, 25, 120, 184),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                color: Colors.white,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(top: 5, left: 10, bottom: 5, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Amount",
                          style: GoogleFonts.zillaSlab(
                              fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextField(
                        controller: credit,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.robotoMono(
                            fontSize: 25, color: Colors.black),
                        decoration: InputDecoration(
                            prefix: Text(
                          '\$ ',
                          style: GoogleFonts.zillaSlab(
                              fontSize: 25, color: Colors.black),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          "To",
                          style: GoogleFonts.zillaSlab(
                              fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextField(
                        style: GoogleFonts.robotoMono(color: Colors.black),
                        controller: TextEditingController(text: last),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  Get.to(() => Scaffold(
                                        body: MobileScanner(
                                          controller: MobileScannerController(
                                              detectionSpeed:
                                                  DetectionSpeed.noDuplicates,
                                              returnImage: true),
                                          onDetect: (capture) {
                                            final List<Barcode> barcodes =
                                                capture.barcodes;
                                            setState(() {
                                              last =
                                                  barcodes.first.rawValue ?? "";
                                            });
                                            final Uint8List? image =
                                                capture.image;
                                            if (image != null) {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      barcodes.first.rawValue ??
                                                          "empty",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    content: Image(
                                                        image:
                                                            MemoryImage(image)),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                            Get.back();
                                                          },
                                                          child: Text(
                                                              'QR CODE SAVED'))
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ));
                                },
                                icon: Icon(
                                  Icons.qr_code_scanner,
                                  color: Colors.grey,
                                ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Text(
                          "From",
                          style: GoogleFonts.zillaSlab(
                              fontSize: 18, color: Colors.black),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: theme.getDarkTheme
                            ? null
                            : Color.fromARGB(255, 25, 120, 184),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      student.name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "KCG PAY",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8.0, top: 20),
                                child: Text(
                                  student.department,
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 187, 187, 187)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "********${student.rollno.substring(student.rollno.length - 4)}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, letterSpacing: 3),
                                  ),
                                  Text(
                                    "***",
                                    style: TextStyle(
                                        color: Colors.white, letterSpacing: 3),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.getDarkTheme
                                    ? themeColor.darkTheme
                                    : Color.fromARGB(255, 25, 120, 184),
                              ),
                              onPressed: () async {
                                int? creditAmount = int.tryParse(credit.text);
                                //your custom configuration
                                await ftts.setLanguage("ta");
                                await ftts.setSpeechRate(0.5); //speed of speech
                                await ftts.setVolume(1.0); //volume of speech
                                await ftts.setPitch(1); //pitc of sound

                                //play text to sp
                                var result = await ftts
                                    .speak("KCG PAY il ${creditAmount} ரூபாய் அனுப்பப்பட்டது");
                                if (result == 1) {
                                  //speaking
                                } else {
                                  //not speaking
                                }
                                if (creditAmount != null) {
                                  sendCredit(student.id, last, creditAmount);
                                } else {
                                  print(
                                      'Invalid credit amount: ${credit.text}');
                                }
                              },
                              child: Text("send Now")),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
