import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:campuslink/Util/FontStyle/RobotoMediumFont.dart';

class TopBarArea extends StatelessWidget {
  final String title;
  final Function()? onQrCodeTap;
  final bool isQrCodeVisible;
  final bool enablearrow;

  const TopBarArea(
      {Key? key,
      required this.title,
      this.isQrCodeVisible = false,
      this.onQrCodeTap,
      this.enablearrow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            enablearrow
                ? Align(
                    alignment: Directionality.of(context) == TextDirection.rtl
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            right:
                                Directionality.of(context) == TextDirection.rtl
                                    ? 10
                                    : 0,
                            left:
                                Directionality.of(context) == TextDirection.rtl
                                    ? 0
                                    : 10),
                        child: const Icon(
                          BoxIcons.bx_arrow_back,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
                RobotoMediumFont(text: title, size: 17)
            ,
            Visibility(
              visible: isQrCodeVisible,
              child: Align(
                alignment: Directionality.of(context) == TextDirection.rtl
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: InkWell(
                  onTap: onQrCodeTap,
                  child: Container(
                    height: 36,
                    width: 36,
                    margin: EdgeInsets.only(
                        right: Directionality.of(context) == TextDirection.rtl
                            ? 0
                            : 10,
                        left: Directionality.of(context) == TextDirection.rtl
                            ? 0
                            : 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.qr_code_2,
                    ),
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
