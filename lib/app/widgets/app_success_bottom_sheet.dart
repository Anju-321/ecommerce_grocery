import 'dart:async';
import 'package:ecommerce_tis/app/widgets/app_lottie.dart';
import 'package:ecommerce_tis/app/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/screen_utils.dart';
import '../../core/style/colors.dart';
import '../../core/style/fonts.dart';

class AppSuccessBottomSheet extends StatelessWidget {
  const AppSuccessBottomSheet({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Screen.close();
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AppLottie(
            assetName: "verified",
            height: 100,
            width: 100,
          ),
          AppText(
            text,
            style: headline.copyWith(color: primaryClr),
          )
        ],
      ),
    );
  }
}
