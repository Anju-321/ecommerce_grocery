import 'package:ecommerce_tis/app/view/home/home_view.dart';
import 'package:get/get.dart';

import '../../core/screen_utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    
    Future.delayed(const Duration(seconds: 3), () async {

        
        Screen.openAsNewPage( const HomeView());
      
    });
  }
}