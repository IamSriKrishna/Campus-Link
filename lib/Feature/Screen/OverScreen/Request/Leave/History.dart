import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/Widget/CustomDay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Feature/Service/FormService.dart';
import 'package:campuslink/Model/Form.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class History extends StatefulWidget {
  static const route = '/History';
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<FormModel>? fetchFromForm;
  late Timer _timer;
  FormService _formService = FormService();
  void retreive() async {
    fetchFromForm = await _formService.DisplayForm(context: context);
    setState(() {});
  }

  void _deleteForm(String FormId) async {
    final url = Uri.parse('$uri/kcg/student/form/$FormId');
    http.Response res = await http.delete(url);
    if (res.statusCode == 200) {
      Get.back();
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      retreive();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentProvider>(context).user;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(
              S.current.history,
              style: GoogleFonts.merriweather(),
            ),
            backgroundColor: theme.getDarkTheme
                ? themeColor.darkTheme
                : themeColor.backgroundColor,
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Padding(
                padding: const EdgeInsets.only(right:15.0),
                child: Text('${student.name}'),
              )],
            ),
          ),
          fetchFromForm == null
              ? SliverList.builder(
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Shimmer effect for post image
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AspectRatio(
                              aspectRatio: 3.5,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                        ],
                      ),
                    );
                  },
                )
              : SliverList.builder(
                  itemCount: fetchFromForm!.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = fetchFromForm!.length - 1 - index;
                    final form = fetchFromForm![
                        reversedIndex]; // Get data in reverse order
                    // Inside your ListView.builder itemBuilder
                    DateTime createdAt = form
                        .createdAt; // Assuming form.createdAt is a DateTime object
                    DateTime now = DateTime.now();
                    String createdAtFormatted;

                    if (createdAt.year == now.year &&
                        createdAt.month == now.month &&
                        createdAt.day == now.day) {
                      // Today
                      createdAtFormatted = 'Today';
                    } else if (createdAt.year == now.year &&
                        createdAt.month == now.month &&
                        createdAt.day == now.day - 1) {
                      // Yesterday
                      createdAtFormatted = 'Yesterday';
                    } else {
                      // Another day
                      createdAtFormatted = DateFormat('E, MMM d').format(
                          createdAt); // Format as day of the week and date
                    }

                    return DelayedDisplay(
                      delay: Duration(milliseconds: 70 * index),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onLongPress: () {
                            showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: Text(S.current.warning),
                                content: Text(
                                    "To proceed with the deletion of this form, please acknowledge that your credit will not be refunded upon confirmation."),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('NO'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text('YES'),
                                    onPressed: () => _deleteForm(form.id),
                                  ),
                                ],
                              ),
                            );
                          },
                          onTap: () {
                            showCupertinoDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                content: Container(
                                  alignment: Alignment.center,
                                  height:
                                      200, // Adjust the height according to your requirement
                                  width:
                                      200, // Adjust the width according to your requirement
                                  child: QrImageView(
                                    data:
                                        'Name:${form.name}\n   ${form.formtype}:${form.response}\n    $createdAtFormatted',
                                    version: QrVersions.auto,
                                    size: 200.0,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: theme.getDarkTheme
                                ? Color.fromARGB(255, 21, 76, 97)
                                : Color.fromARGB(255, 255, 255, 255),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //Display Title, Request and Approval
                                        Text(
                                          form.formtype,
                                          style: GoogleFonts.merriweather(
                                              color: theme.getDarkTheme
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        //Display Request and Approval
                                        AvatarGlow(
                                          glowRadiusFactor: 0.5,
                                          glowColor: form.response ==
                                                  'Requested'
                                              ? Colors.orange
                                              : form.response == 'Accepted'
                                                  ? Colors.green
                                                  : form.response == 'OnProcess'
                                                      ? Colors.blue
                                                      : Colors.red,
                                          child: Card(
                                            color: form.response == 'Requested'
                                                ? Colors.orange
                                                : form.response == 'Accepted'
                                                    ? Colors.green
                                                    : form.response ==
                                                            'OnProcess'
                                                        ? Colors.blue
                                                        : Colors.red,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                form.response == 'Requested'
                                                    ? 'Requested :|'
                                                    : form.response ==
                                                            'Accepted'
                                                        ? 'Accepted :)'
                                                        : form.response ==
                                                                'OnProcess'
                                                            ? "OnProcess :/"
                                                            : 'Rejected :(',
                                                style: GoogleFonts.merriweather(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //Display From, To and No of Days
                                            Text(
                                              '${S.current.from}:${form.from}',
                                              style: GoogleFonts.merriweather(
                                                color: theme.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '${S.current.to}:${form.to}',
                                              style: GoogleFonts.merriweather(
                                                color: theme.getDarkTheme
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                        //Display No of Days
                                        form.formtype != 'Gate Pass'
                                            ? Text(
                                                '${S.current.noofdays}:${form.no_of_days}',
                                                style: GoogleFonts.merriweather(
                                                  color: theme.getDarkTheme
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              )
                                            : dateWidget(
                                                form.createdAt, context),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }
}
