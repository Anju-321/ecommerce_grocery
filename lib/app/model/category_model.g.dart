// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductCategoryAdapter extends TypeAdapter<ProductCategory> {
  @override
  final int typeId = 0;

  @override
  ProductCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductCategory(
      categoryName: fields[1] as String,
      imageUrl: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductCategory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.categoryName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
