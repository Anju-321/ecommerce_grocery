
import 'package:hive_flutter/hive_flutter.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 2)
class Cart{
   
   @HiveField(0)
  final String productName;

     @HiveField(1)
  final String imageUrl;

     @HiveField(2)
  final num unitPrice;

   @HiveField(3)
   num quantity;

   @HiveField(4)
   num subtotal;
   
  @HiveField(5)
  final int id;




  Cart(this.imageUrl, this.unitPrice, this.quantity, this.subtotal,this.productName, {required  this.id});

}