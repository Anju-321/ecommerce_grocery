import 'package:ecommerce_tis/app/widgets/app_lottie.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: AppLottie(assetName: "loader", width: 90, height: 90));
  }
}
