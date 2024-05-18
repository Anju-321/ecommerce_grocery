import 'package:ecommerce_tis/app/controller/product_controller.dart';
import 'package:ecommerce_tis/app/view/product/product_view.dart';
import 'package:ecommerce_tis/app/widgets/app_cached_image.dart';
import 'package:ecommerce_tis/core/extensions/margin_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../core/screen_utils.dart';
import '../../../core/style/colors.dart';
import '../../../core/style/fonts.dart';
import '../../model/cart_model.dart';
import '../../widgets/app_text.dart';
import '../home/home_view.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key, this.customerId});
  final String? customerId;

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(ProductController());
    debugPrint("...........$customerId");

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          "My Cart",
          style: titleTwo.copyWith(color: primaryClr),
        ),
        iconTheme: const IconThemeData(color: primaryClr),
      ),
      bottomNavigationBar:((customerId != null) && (controller.cartList.isNotEmpty)) ?  CheckoutButton(onTap: () async{
       await controller.placeOrder(customerId:int.parse(customerId??""));

       Screen.openAsNewPage(const HomeView());
       
    
      },):null,
      body: Obx( () {
        if(controller.cartList.isEmpty){
        return  Center(child: AppText("No Items in the Cart",style: subheadOne.copyWith(color: Colors.red),align: TextAlign.center,));
        }
      return ListView.separated(
          shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) => ProductCheckoutTile(cartItem: controller.cartList[index],),
            itemCount: controller.cartList.length,
            separatorBuilder: (context, index) => 8.hBox,
         
        );}
      ),
    );
  }
}

class ProductCheckoutTile extends StatelessWidget {
  const ProductCheckoutTile({
    super.key, required this.cartItem,
  });

  final Cart cartItem;

  @override
  Widget build(BuildContext context) {
     final controller = Get.find<ProductController>();

    return Stack(
      children:[ Column(
        children: [
          12.hBox,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 14),
            decoration: BoxDecoration(
                color: highlightTextClr,
                borderRadius: BorderRadius.circular(6)),
            child:  Row(
              children: [
                40.wBox,
          
           SizedBox(
            width: 100,
             child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                       cartItem.productName ,
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: inter6SemiBold,
                            fontSize: 12,
                            color: primaryClr),
                      ),
                      RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "₹${cartItem.unitPrice}",
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
               
                 Row(
                        children: [
                          Obx(() {
                            return controller.cartList
                                        .firstWhere(
                                          (item) => item.id == cartItem.id,
                                          orElse: () => Cart('', 0, 0, 0, '',
                                              id: cartItem.id),
                                        )
                                        .quantity !=
                                    0
                                ? GestureDetector(
                                    onTap: () {
                                      controller.removeFromCart(controller.productList.firstWhere((product) => product.id == cartItem.id));
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
                                          (item) => item.id == cartItem.id,
                                          orElse: () => Cart('', 0, 0, 0, '',
                                              id: cartItem.id),
                                        )
                                        .quantity !=
                                    0
                                ? SizedBox(
                                    width: 30,
                                    child: AppText(
                                      align: TextAlign.center,
                                      controller.cartList
                                          .firstWhere(
                                            (item) => item.id == cartItem.id,
                                            orElse: () => Cart('', 0, 0, 0, '',
                                                id: cartItem.id),
                                          )
                                          .quantity
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ))
                                : 0.wBox;
                          }),
                          GestureDetector(
                            onTap: () async {
                              controller.addToCart(controller.productList.firstWhere((product) => product.id == cartItem.id));
                              controller.calculateTotal();
                            },
                            child: const Icon(
                              Icons.add_circle,
                              color: primaryClr,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                     AppText(
                    "₹${cartItem.subtotal}",
                    overflow: TextOverflow.ellipsis,
                    style: titleTwo.copyWith(color: primaryClr),
                  )
                    ],
                  ),
          ),
        ],
      ),
       Positioned(
            left: 16,
            top: 0,
            child: CachedImage(
    imageUrl:controller.productList.firstWhere((product) => product.id == cartItem.id).image ,
   
    height: 50,
    width: 35,
            ),
          ),
      
      ]
    );
  }
}
