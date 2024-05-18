import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_tis/app/controller/home_controller.dart';
import 'package:ecommerce_tis/app/controller/product_controller.dart';
import 'package:ecommerce_tis/app/model/category_model.dart';
import 'package:ecommerce_tis/app/model/discovery_item_model.dart';
import 'package:ecommerce_tis/app/view/checkout/checkout_view.dart';
import 'package:ecommerce_tis/app/view/customer/customer_view.dart';
import 'package:ecommerce_tis/app/view/product/product_view.dart';
import 'package:ecommerce_tis/app/widgets/app_bottom_nav.dart';
import 'package:ecommerce_tis/app/widgets/app_cached_image.dart';
import 'package:ecommerce_tis/app/widgets/app_text.dart';
import 'package:ecommerce_tis/app/widgets/app_text_field.dart';
import 'package:ecommerce_tis/core/extensions/margin_ext.dart';
import 'package:ecommerce_tis/core/screen_utils.dart';
import 'package:ecommerce_tis/core/style/colors.dart';
import 'package:ecommerce_tis/core/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../widgets/app_loader.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final productController = Get.put(ProductController());
    final List carouselImages = [
      'assets/images/carousal1.png',
      'assets/images/carousal2.png',
      'assets/images/carousal3.png',
      'assets/images/carousal4.png',
      'assets/images/carousal5.png',
    ];

    final List screens = [
      const HomeView(),
      const ProductView(),
      const CustomerView()
    ];

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          "Good Day! 👋🏻",
          style: titleTwo.copyWith(color: primaryClr),
        ),
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: -6,end: -6),
            badgeContent: Obx(
              () {
                
              return AppText(
              
              productController.cartCount.value,
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
      bottomNavigationBar: AppBottomNav(onTap: (index) {
        Screen.open(screens[index]);
      }),
      body: LiquidPullToRefresh(
         backgroundColor: primaryClr,
                  animSpeedFactor: 2,
                  color: primaryClr.withOpacity(0.2),
                  showChildOpacityTransition: false,
        child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppTextField(
              borderRadius: 24,
              bgColor: highlightTextClr,
              hint: "Search grocery",
              onChanged: (p0) {
                controller.searchCategories(p0);
              },
              borderClr: highlightTextClr,
              prefixIcon: const Icon(
                Icons.search,
                color: inputHintClr,
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              aspectRatio: 1.5,
            ),
            items: carouselImages.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return CachedImage(
                    width: 280,
                    imageUrl: i,
                    isAssetImg: true,
                    radius: 12,
                  );
                },
              );
            }).toList(),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: AppText(
              "Categories",
              style: TextStyle(
                  fontFamily: inter6SemiBold, fontSize: 18, color: primaryClr),
            ),
          ),
          SizedBox(
              height: 70,
              child: Obx(() {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CategoryContainer(
                      category: controller.homeCategoryList[index],
                    );
                  },
                  itemCount: controller.homeCategoryList.length,
                  separatorBuilder: (context, index) => 10.wBox,
                );
              })),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AppText(
                  "Discovery",
                  style: TextStyle(
                      fontFamily: inter6SemiBold,
                      fontSize: 18,
                      color: primaryClr),
                ),
                const Spacer(),
                AppText(
                  "See All >",
                  style: captionOne.copyWith(color: primaryClr),
                  onTap: () => Screen.open(const ProductView()),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                if (controller.discoveryList.isEmpty) {
                  return const AppLoader();
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() {
                        return DiscoveryContainer(
                          item: controller.discoveryList[0],
                          controller: controller,
                        );
                      }),
                      const Spacer(),
                      Obx(() {
                        return DiscoveryContainer(
                          item: controller.discoveryList[1],
                          controller: controller,
                        );
                      }),
                    ],
                  );
                }
              })),
        ],
      ), onRefresh: ()async {
        controller.searchCategories("");
        
      },)
     
    );
  }
}

class DiscoveryContainer extends StatelessWidget {
  const DiscoveryContainer({
    super.key,
    required this.item,
    required this.controller,
  });

  final DiscoveryItem item;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          35.hBox,
          Container(
            width: 150,
            decoration: BoxDecoration(
                color: highlightTextClr,
                borderRadius: BorderRadius.circular(18)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        item.isliked ? Icons.favorite : Icons.favorite_border,
                        color: item.isliked ? Colors.red : null,
                        size: 20,
                      ),
                      onPressed: () {
                        controller.toggleLike(item);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText(
                            item.itemName,
                            style: const TextStyle(
                                fontFamily: inter6SemiBold,
                                fontSize: 12,
                                color: primaryClr),
                          ),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "\$10",
                                  style: TextStyle(
                                    fontFamily: inter6SemiBold,
                                    fontSize: 18,
                                    color: primaryClr,
                                  ),
                                ),
                                TextSpan(
                                  text: "/Kg",
                                  style: TextStyle(
                                    fontFamily: inter6SemiBold,
                                    fontSize:
                                        12, // Adjust font size for smaller text
                                    color: Colors
                                        .grey, // Change color to light grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
        left: 50,
        bottom: 80,
        child: CachedImage(
          imageUrl: item.imageUrl,
          isAssetImg: true,
          height: 50,
          width: 45,
        ),
      ),
    ]);
  }
}

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    super.key,
    required this.category,
  });
  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: highlightTextClr),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedImage(
            imageUrl: category.imageUrl,
            height: 25,
            width: 25,
            isAssetImg: true,
          ),
          4.hBox,
          SizedBox(
            width: 35,
            child: AppText(
              category.categoryName,
              overflow: TextOverflow.ellipsis,
              style: captionOne.copyWith(color: primaryClr),
            ),
          )
        ],
      ),
    );
  }
}
