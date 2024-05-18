import 'package:ecommerce_tis/app/controller/product_controller.dart';
import 'package:ecommerce_tis/app/view/customer/customer_view.dart';
import 'package:ecommerce_tis/app/widgets/app_loader.dart';
import 'package:ecommerce_tis/core/extensions/margin_ext.dart';
import 'package:ecommerce_tis/core/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:badges/badges.dart' as badges;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../core/style/colors.dart';
import '../../../core/style/fonts.dart';
import '../../model/cart_model.dart';
import '../../model/product_model.dart';
import '../../widgets/app_cached_image.dart';
import '../../widgets/app_text.dart';
import '../checkout/checkout_view.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController(),);
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          "Products",
          style: titleTwo.copyWith(color: primaryClr),
        ),
        iconTheme: const IconThemeData(color: primaryClr),
        actions: [
          badges.Badge(
            badgeContent: Obx(
              () {
                
              return AppText(
              controller.cartCount.value,
              style: captionOne.copyWith(color: Colors.white),
            );}),
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: highlightTextClr),
                child: GestureDetector(
                  onTap: () {
                    Screen.open(const CheckOutView());
                  },
                  child: const Icon(
                    Icons.shopping_cart_checkout_outlined,
                    color: primaryClr,
                  ),
                )),
          ),
          16.wBox
        ],
      ),
      bottomNavigationBar: CheckoutButton(
        onTap: () => Screen.open(const CustomerView()),
      ),
      body:LiquidPullToRefresh(onRefresh: ()async {
        controller.getProduct();
        
      },
      

       child:  Obx(() {
        if (controller.productList.isEmpty) {
          return  Center(child: AppText("No products.",style: subheadOne.copyWith(color: Colors.red),align: TextAlign.center,));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.05,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: controller.productList.length,
          itemBuilder: (context, index) {
            return ProductContainer(
              product: controller.productList[index],
            );
          },
        );
      }))
      
    );
  }
}

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    return Stack(children: [
      Column(
        children: [
          35.hBox,
          Container(
            height: 120,
            decoration: BoxDecoration(
                color: highlightTextClr,
                borderRadius: BorderRadius.circular(18)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(
                              maxLines: 2,
                              product.name,
                              style: const TextStyle(
                                  fontFamily: inter6SemiBold,
                                  fontSize: 10,
                                  color: primaryClr),
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "₹${product.price}",
                                    style: const TextStyle(
                                      fontFamily: inter6SemiBold,
                                      fontSize: 14,
                                      color: primaryClr,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "/Kg",
                                    style: TextStyle(
                                      fontFamily: inter6SemiBold,
                                      fontSize:
                                          10, // Adjust font size for smaller text
                                      color: Colors
                                          .grey, // Change color to light grey
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Obx(() {
                            return controller.cartList
                                        .firstWhere(
                                          (item) => item.id == product.id,
                                          orElse: () => Cart('', 0, 0, 0, '',
                                              id: product.id),
                                        )
                                        .quantity !=
                                    0
                                ? GestureDetector(
                                    onTap: () {
                                      controller.removeFromCart(product);
                                      controller.calculateTotal();
                                    },
                                    child: const Icon(
                                      Icons.do_not_disturb_on_outlined,
                                      color: primaryClr,
                                    ),
                                  )
                                : 0.hBox;
                          }),
                          Obx(() {
                            return controller.cartList
                                        .firstWhere(
                                          (item) => item.id == product.id,
                                          orElse: () => Cart('', 0, 0, 0, '',
                                              id: product.id),
                                        )
                                        .quantity !=
                                    0
                                ? SizedBox(
                                    width: 30,
                                    child: AppText(
                                      align: TextAlign.center,
                                      controller.cartList
                                          .firstWhere(
                                            (item) => item.id == product.id,
                                            orElse: () => Cart('', 0, 0, 0, '',
                                                id: product.id),
                                          )
                                          .quantity
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ))
                                : 0.wBox;
                          }),
                          GestureDetector(
                            onTap: () async {
                              controller.addToCart(product);
                              controller.calculateTotal();
                            },
                            child: const Icon(
                              Icons.add_circle,
                              color: primaryClr,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                24.hBox
              ],
            ),
          ),
        ],
      ),
      Positioned(
        left: 60,
        top: 12,
        child: CachedImage(
          imageUrl: product.image,
          height: 50,
          width: 35,
        ),
      ),
    ]);
  }
}

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: btmnClr,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  "Subtotal",
                  style: subheadTwo.copyWith(color: inputHintClr),
                ),
                4.hBox,
                Obx(() {
                  return AppText(
                    "₹${controller.totalSum.value}",
                    style: titleTwo.copyWith(color: primaryClr),
                  );
                })
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                onTap?.call();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24), color: primaryClr),
                child: AppText(
                  "Checkout Now",
                  style: subheadOne.copyWith(color: highlightTextClr),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
