import 'package:ecommerce_tis/app/controller/splash_controller.dart';
import 'package:ecommerce_tis/core/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
   
    return Scaffold(
      backgroundColor: highlightTextClr,
        body: Center(
            child: Padding(
      padding: const EdgeInsets.all(120.0),
      child: Image.asset("assets/images/logo.png"),
    )));
  }
}
