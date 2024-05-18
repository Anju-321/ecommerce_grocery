import 'package:ecommerce_tis/app/model/cart_model.dart';
import 'package:ecommerce_tis/app/model/discovery_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/model/category_model.dart';
import 'app/view/splash/splash_view.dart';
import 'core/theme.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
   if(!Hive.isAdapterRegistered(ProductCategoryAdapter().typeId)){
     Hive.registerAdapter(ProductCategoryAdapter());
    
   }

     if(!Hive.isAdapterRegistered(DiscoveryItemAdapter().typeId)){
     Hive.registerAdapter(DiscoveryItemAdapter());
    
   }

   if(!Hive.isAdapterRegistered(CartAdapter().typeId)){
     Hive.registerAdapter(CartAdapter());
    
   }

    await Hive.openBox<Cart>('cartBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     
     
      debugShowCheckedModeBanner: false,
      title: 'FreshDay',
      theme: appTheme,
      home: const SplashView(),
    );
  }
}
