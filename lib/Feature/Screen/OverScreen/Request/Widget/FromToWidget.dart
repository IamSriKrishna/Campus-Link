// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

class FromToWidget extends StatefulWidget {
  TimeOfDay selectedFrom;
  TimeOfDay selectedTo;
  FromToWidget(
      {super.key, required this.selectedFrom, required this.selectedTo});

  @override
  State<FromToWidget> createState() => _FromToWidgetState();
}

class _FromToWidgetState extends State<FromToWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: widget.selectedFrom,
                  initialEntryMode: TimePickerEntryMode.dialOnly);
              if (timeOfDay != null) {
                setState(() {
                  widget.selectedFrom = timeOfDay;
                });
              }
            },
            child: SizedBox(
              height: double.infinity,
              width: MediaQuery.of(context).size.width * 0.38,
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.current.from,
                      style: GoogleFonts.merriweather(
                        color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                        fontSize: 18
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.alarm,
                          color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RobotoBoldFont(
                            text:
                                '${widget.selectedFrom.hour}:${widget.selectedFrom.minute}',
                            size: 25,
                            textColor: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                          ),
                        ),
                        widget.selectedFrom.hour >= 12
                            ?
                            Text(
                              'Pm',
                              style: GoogleFonts.merriweather(
                                color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                              ),
                            )
                            : Text(
                              'Am',
                              style: GoogleFonts.merriweather(
                                color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                              ),
                            )
                      ],
                    ),
                    const Divider(
                      indent: 25,
                      endIndent: 25,
                      thickness: 2,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: Image.asset(assetImage.requestForm2)),
          GestureDetector(
            onTap: () async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: widget.selectedTo,
                  initialEntryMode: TimePickerEntryMode.dialOnly);
              if (timeOfDay != null) {
                setState(() {
                  widget.selectedTo = timeOfDay;
                });
              }
            },
            child: SizedBox(
              height: double.infinity,
              width: MediaQuery.of(context).size.width * 0.38,
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.current.to,
                      style: GoogleFonts.merriweather(
                        color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                        fontSize: 18
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.alarm,
                          color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RobotoBoldFont(
                            text:
                                '${widget.selectedTo.hour}:${widget.selectedTo.minute}',
                            size: 25,
                            textColor: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                          ),
                        ),
                        widget.selectedTo.hour >= 12
                        ?
                        Text(
                          'Pm',
                          style: GoogleFonts.merriweather(
                            color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                          ),
                        )
                        : Text(
                          'Am',
                          style: GoogleFonts.merriweather(
                            color: theme.getDarkTheme?themeColor.backgroundColor:themeColor.appBarColor,
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      indent: 25,
                      endIndent: 25,
                      thickness: 2,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
