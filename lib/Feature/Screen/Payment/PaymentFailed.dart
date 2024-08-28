import 'package:avatar_glow/avatar_glow.dart';
import 'package:campuslink/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentFailed extends StatelessWidget {
  final int creditSpent;
  final String receiverId;
  const PaymentFailed(
      {super.key, required this.creditSpent, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentProvider>(context).user;
    final theme = Provider.of<DarkThemeProvider>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.off(() => OverScreen());
      },
      child: Scaffold(
        backgroundColor:
            theme.getDarkTheme ? null : Color.fromARGB(255, 184, 25, 25),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.withOpacity(0.5)),
                              child: AvatarGlow(
                                  duration: Duration(seconds: 2),
                                  glowColor: Colors.red,
                                  glowRadiusFactor: 10,
                                  glowShape: BoxShape.circle,
                                  animate: true,
                                  curve: Curves.easeIn,
                                  child: Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                "Failed",
                                style: GoogleFonts.andika(fontSize: 25),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                "you've Transaction Is failed due to insufficient balance",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.andika(fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(10)),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text('\$${creditSpent}',
                                          style: GoogleFonts.roboto(
                                              fontSize: 25,
                                              color: Colors.blueGrey)),
                                      Text('Amount Sent',
                                          style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("From",
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                      )),
                                  Text(student.id,
                                      style: GoogleFonts.roboto(
                                        fontSize: 11,
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("To",
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                      )),
                                  Text(receiverId,
                                      style: GoogleFonts.roboto(
                                        fontSize: 11,
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Date",
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                      )),
                                  Text(
                                      DateFormat('dd-MMM-yyyy')
                                          .format(DateTime.now()),
                                      style: GoogleFonts.roboto(
                                        fontSize: 11,
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      minimumSize: Size(double.infinity, 40)),
                                  onPressed: () {
                                    Get.off(() => OverScreen());
                                  },
                                  child: Text("Done",
                                      style: GoogleFonts.roboto(
                                        fontSize: 20,
                                      ))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
