import 'package:flutter/material.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/util.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CustomApprovalSliverAppBar extends StatefulWidget {
  final String text;
  final IconData? leadingIcon;
  final double? leadingWidth;
  final void Function()? onTap;

  CustomApprovalSliverAppBar({
    Key? key, // Corrected parameter name
    required this.text,
    this.onTap,
    this.leadingIcon,
    this.leadingWidth,
  });

  @override
  State<CustomApprovalSliverAppBar> createState() => _CustomApprovalSliverAppBarState();
}

class _CustomApprovalSliverAppBarState extends State<CustomApprovalSliverAppBar> {
  @override
  void initState() {
    setState(() {
      
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return Consumer<StudentProvider>(
      builder: (context, student, child) {
        return SliverAppBar(
          stretch: true,
          elevation: 10,
          leading: GestureDetector(
            onTap: widget.onTap,
            child: Icon(
              widget.leadingIcon,
              color: theme.getDarkTheme
                  ? themeColor.backgroundColor
                  : themeColor.appBarColor,
            ),
          ),
          leadingWidth: widget.leadingWidth,
          backgroundColor: theme.getDarkTheme
              ? themeColor.darkTheme
              : themeColor.themeColor,
          title: RobotoBoldFont(
            text: widget.text,
            textColor: theme.getDarkTheme
                ? themeColor.backgroundColor
                : themeColor.appBarColor,
          ),
          floating: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Lottie.asset('asset/lottie/coin.json'),
                  RobotoBoldFont(
                    text: '${student.user.credit}',
                    textColor: theme.getDarkTheme
                        ? themeColor.backgroundColor
                        : themeColor.appBarColor,
                    size: 18,
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
