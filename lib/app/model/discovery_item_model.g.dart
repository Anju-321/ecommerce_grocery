// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discovery_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiscoveryItemAdapter extends TypeAdapter<DiscoveryItem> {
  @override
  final int typeId = 1;

  @override
  DiscoveryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiscoveryItem(
      imageUrl: fields[0] as String,
      itemName: fields[1] as String,
      isliked: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DiscoveryItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.isliked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscoveryItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
