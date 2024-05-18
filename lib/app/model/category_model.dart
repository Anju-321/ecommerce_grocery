import 'package:hive_flutter/hive_flutter.dart';
part 'category_model.g.dart';



@HiveType(typeId: 0)
class ProductCategory{
    @HiveField(0)
   final String imageUrl;

    @HiveField(1)
  final String categoryName;
  ProductCategory({required this.categoryName,required this.imageUrl});
}