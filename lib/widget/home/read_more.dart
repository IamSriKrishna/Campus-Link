import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_palette.dart';
import 'package:campuslink/widget/components/components.dart';

class ReadMoreTextWidget extends StatefulWidget {
  final String username;
  final String description;

  const ReadMoreTextWidget({super.key, required this.username, required this.description});

  @override
  _ReadMoreTextWidgetState createState() => _ReadMoreTextWidgetState();
}

class _ReadMoreTextWidgetState extends State<ReadMoreTextWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final String usernameText = widget.username;
    final String descriptionText = widget.description;

    // Measure the text height
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        style: Components.fontFamily(fontSize: 14.sp),
        text: descriptionText,
      ),
      maxLines: 2,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 20.w);

    final bool isTextOverflowing = textPainter.didExceedMaxLines;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 5.h),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        _buildUsernameTextSpan(usernameText),
                        _buildDescriptionTextSpan(
                          _isExpanded ? descriptionText : _truncateText(descriptionText),
                        ),
                      ],
                    ),
                  ),
                  if (isTextOverflowing)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        _isExpanded ? AppContent.showless : AppContent.showMore,
                        style: Components.fontFamily(color: AppPalette.mette.withOpacity(0.5)),
                      ),
                    ),
                ],
              ),
              secondChild: RichText(
                text: TextSpan(
                  children: [
                    _buildUsernameTextSpan(usernameText),
                    _buildDescriptionTextSpan(descriptionText),
                  ],
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
            ),
          ],
        ),
      ),
    );
  }

  TextSpan _buildUsernameTextSpan(String username) {
    return TextSpan(
      text: "$username: ",
      style: Components.fontFamily(
        fontWeight: FontWeight.bold,
        fontSize: 14.sp,
        color: AppPalette.mette,
      ),
    );
  }

  TextSpan _buildDescriptionTextSpan(String text) {
    final List<TextSpan> spans = [];
    final regex = RegExp(r'(@\w+|#\w+)');
    final matches = regex.allMatches(text);

    int lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: Components.fontFamily(fontSize: 14.sp, color: AppPalette.mette),
        ));
      }

      spans.add(TextSpan(
        text: match.group(0),
        style: Components.fontFamily(fontSize: 14.sp, color: Colors.blue),
      ));

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: Components.fontFamily(fontSize: 14.sp, color: AppPalette.mette),
      ));
    }

    return TextSpan(children: spans);
  }

  String _truncateText(String text) {
    const maxLines = 2;
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: Components.fontFamily(fontSize: 14.sp),
      ),
      maxLines: maxLines,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 20.w);

    if (textPainter.didExceedMaxLines) {
      final endIndex = textPainter.getPositionForOffset(
        Offset(MediaQuery.of(context).size.width - 20.w, textPainter.size.height),
      ).offset;
      return '${text.substring(0, endIndex)}...';
    }

    return text;
  }
}
