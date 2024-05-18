import 'package:ecommerce_tis/app/controller/product_controller.dart';
import 'package:ecommerce_tis/app/model/category_model.dart';
import 'package:ecommerce_tis/app/model/discovery_item_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController {

  RxList<ProductCategory> homeCategoryList=<ProductCategory>[].obs;

  RxList<DiscoveryItem> discoveryList=<DiscoveryItem>[].obs;

  RxBool isliked = false.obs;

   

 
  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
    await createCategory();
    await createDiscoveryItems();

    
    
  }

   Future<void> createCategory() async {
   
    await Hive.openBox<ProductCategory>('categoriesBox');

    if (Hive.box<ProductCategory>('categoriesBox').isEmpty) {
      List<ProductCategory> initialCategories = [
        ProductCategory(categoryName: "Dairy", imageUrl: "assets/images/dairy.png"),
        ProductCategory(categoryName: "Fish", imageUrl: "assets/images/fish.png"),
        ProductCategory(categoryName: "Meat", imageUrl: "assets/images/meat.png"),
        ProductCategory(categoryName: "Spices", imageUrl: "assets/images/spices.png"),
        ProductCategory(categoryName: "Vegetables", imageUrl: "assets/images/vegetables.png"),
        ProductCategory(categoryName: "Fruits", imageUrl: "assets/images/fruits.png"),
      ];
      var box = Hive.box<ProductCategory>('categoriesBox');
      for (var category in initialCategories) {
        box.add(category);
      }
    }

    homeCategoryList.value = Hive.box<ProductCategory>('categoriesBox').values.toList();
  }

  void searchCategories(String query) {
    var box = Hive.box<ProductCategory>('categoriesBox');
    if (query.isEmpty) {
      homeCategoryList.value = box.values.toList();
    } else {
      homeCategoryList.value = box.values
          .where((category) =>
              category.categoryName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }


   Future<void> createDiscoveryItems() async {
    await Hive.openBox<DiscoveryItem>('discoveryBox');
    if (Hive.box<DiscoveryItem>('discoveryBox').isEmpty) {
      List<DiscoveryItem> initialItems = [
        DiscoveryItem(imageUrl:"assets/images/apple.png",itemName: "Apple",isliked: false
          
        ),
        DiscoveryItem(itemName: "Mango", imageUrl:"assets/images/mango.png",isliked: false),
      ];
      var box = Hive.box<DiscoveryItem>('discoveryBox');
      for (var item in initialItems) {
        box.add(item);
      }
    }
    discoveryList.value = Hive.box<DiscoveryItem>('discoveryBox').values.toList();
  }


    void toggleLike(DiscoveryItem item) {
    var box = Hive.box<DiscoveryItem>('discoveryBox');
    int index = box.values.toList().indexOf(item);
    if (index != -1) {
      item.isliked = !item.isliked;
      box.putAt(index, item);
      discoveryList[index] = item;
    }
  }



  
  
}
