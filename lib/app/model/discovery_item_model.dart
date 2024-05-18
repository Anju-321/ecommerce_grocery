
import 'package:hive_flutter/hive_flutter.dart';
part 'discovery_item_model.g.dart';

@HiveType(typeId: 1)
class DiscoveryItem{

     @HiveField(0)
   final String imageUrl;

    @HiveField(1)
  final String itemName;
   
   @HiveField(2)
   bool isliked;




  DiscoveryItem({required this.imageUrl,required this.itemName, required this.isliked});
}