import 'package:ecommerce_tis/app/controller/customer_controller.dart';
import 'package:ecommerce_tis/app/model/customer_response_model.dart';
import 'package:ecommerce_tis/app/view/checkout/checkout_view.dart';
import 'package:ecommerce_tis/app/widgets/app_cached_image.dart';
import 'package:ecommerce_tis/app/widgets/app_loader.dart';
import 'package:ecommerce_tis/app/widgets/app_svg.dart';
import 'package:ecommerce_tis/app/widgets/app_text.dart';
import 'package:ecommerce_tis/app/widgets/app_text_field.dart';
import 'package:ecommerce_tis/core/extensions/margin_ext.dart';
import 'package:ecommerce_tis/core/extensions/string_ext.dart';
import 'package:ecommerce_tis/core/screen_utils.dart';
import 'package:ecommerce_tis/core/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/style/fonts.dart';

class CustomerView extends StatelessWidget {
  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
   final controller= Get.put(CustomerController());
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          "Customers",
          style: titleTwo.copyWith(color: secondaryBrandClr),
        ),
      ),
      body: Column(
        children: [
         Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppTextField(
              hint: "Search Customer",
              borderRadius: 18,
              suffixIcon: const Icon(CupertinoIcons.search, size: 20),
              onChanged: (p0) async{ controller.customerList.value= await controller.getCustomer(query: p0);},
            ),
          ),
          Expanded(
            child: Obx(() {
              if(controller.customerList.isEmpty){
                 Center(child: AppText("No Customers",style: subheadOne.copyWith(color: Colors.red),align: TextAlign.center,));
              }
              
            return ListView.separated(
                padding: const EdgeInsets.only(right: 16,left: 16,bottom: 60),
                shrinkWrap: true,
                  itemBuilder: (context, index) =>  CustomerTile(customer: controller.customerList[index],),
                  separatorBuilder: (context, index) => 12.hBox,
                  itemCount: controller.customerList.length);}
            ),
          )
        ],
      ),
    );
  }
}

class CustomerTile extends StatelessWidget {
  const CustomerTile({
    super.key, required this.customer,
  });

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      tileColor: highlightTextClr,
      onTap: () {
        Screen.open(CheckOutView(customerId: customer.id.toString(),));
      },
      leading: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
        child:  CachedImage(
          imageUrl: customer.profilePic,
          
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           AppText(
            customer.name.upperFirst,
            style: const TextStyle(
                fontFamily: inter6SemiBold,
                fontSize: 14,
                color: secondaryBrandClr),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                CupertinoIcons.phone_circle,
                size: 20,
              ),
              4.wBox,
              const AppSvg(
                assetName: "whatsappIcons",
                height: 25,
                width: 25,
              )
            ],
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            "ID: ${customer.id}",
            style: captionOne,
          ),
          AppText(
           "${customer.street.upperFirst}, ${customer.city.upperFirst},${customer.state.upperFirst}",
            style: captionOne,
          ),
        ],
      ),
    );
  }
}
