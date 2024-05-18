import 'dart:convert';
import 'package:ecommerce_tis/app/view/home/home_view.dart';
import 'package:ecommerce_tis/app/widgets/app_success_bottom_sheet.dart';
import 'package:ecommerce_tis/core/screen_utils.dart';
import 'package:ecommerce_tis/shared/dialog/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../../core/service/urls.dart';
import '../model/cart_model.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  RxList<Product> productList = <Product>[].obs;
  RxList<Cart> cartList = <Cart>[].obs;
  Box<Cart> cartBox = Hive.box<Cart>('cartBox');
  RxString totalSum = "".obs;
  RxString cartCount = "".obs;

  getProduct() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      final productdata = ProductResponse.fromJson(data);

      debugPrint("...........${productdata.data}");
      return productdata.data;
    } else {
      return [];
    }
  }

  @override
  void onInit() async {
    super.onInit();
    productList.value = await getProduct();
    cartList.value = cartBox.values.toList();
     cartCount.value=cartBox.values.toList().length.toString();
    await calculateTotal();
  }

  void addToCart(Product product) {
    final cartItem = cartBox.values.firstWhere(
      (item) => item.id == product.id,
      orElse: () => Cart(product.image, product.price, 0, 0, product.name,
          id: product.id),
    );

    if (cartItem.quantity == 0) {
      cartBox.put(
          product.id,
          Cart(product.image, product.price, 1, product.price, product.name,
              id: product.id));
    } else {
      cartBox.put(
        product.id,
        Cart(product.image, product.price, cartItem.quantity + 1,
            cartItem.unitPrice * (cartItem.quantity + 1), product.name,
            id: product.id),
      );
    }

    cartList.value = cartBox.values.toList();
    cartCount.value=cartBox.values.toList().length.toString();

    update();
  }

  void removeFromCart(Product product) {
    final cartItem = cartBox.values.firstWhere(
      (item) => item.id == product.id,
      orElse: () => Cart(product.image, product.price, 0, 0, product.name,
          id: product.id),
    );

    if (cartItem.quantity > 1) {
      cartBox.put(
        product.id,
        Cart(product.image, product.price, cartItem.quantity - 1,
            cartItem.unitPrice * (cartItem.quantity - 1), product.name,
            id: product.id),
      );
    } else {
      cartBox.delete(product.id);
    }

    cartList.value = cartBox.values.toList();
     cartCount.value=cartBox.values.toList().length.toString();
    update();
  }

  calculateTotal() async {
    double total = 0;
    for (var item in cartList) {
      total += item.subtotal;
    }
    return totalSum.value = total.round().toString();
  }

  placeOrder({required int customerId}) async {
    // int customerId,num totalPrice, List products

     final List<Map<String, dynamic>> productList = cartList.map((cart) {
      return {
        "product_id": cart.id,
        "quantity": cart.quantity,
        "price": cart.unitPrice
      };
    }).toList();

    debugPrint("..........$productList");

    final body = {
      "customer_id": customerId,
      "total_price":int.parse(totalSum.value) ,
      "products": productList
    };
    final response = await http.post(Uri.parse('$baseUrl/orders/'),
        body: json.encode(body), headers: {'Content-Type': 'application/json'});

    debugPrint("....................${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("api working...................");
      await cartBox.clear();
      cartList.value = cartBox.values.toList();
       cartCount.value=cartBox.values.toList().length.toString();
     totalSum.value=await calculateTotal();

      await Get.bottomSheet(
          backgroundColor: Colors.white,
          const ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8), topLeft: Radius.circular(8)),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                  child: AppSuccessBottomSheet(
                      text: "Order Placed Successfully")),
            ),
          ),
             shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8), topLeft: Radius.circular(8))),
        isDismissible: true,
        isScrollControlled: true
          );
      totalSum.value=await calculateTotal();

    } else {
      showToast(
          "Unable to place your order at this time. Please check your internet connection or try again later.");
    }
  }
}
