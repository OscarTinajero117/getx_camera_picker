// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_images.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IdImagesAdapter extends TypeAdapter<IdImages> {
  @override
  final int typeId = 0;

  @override
  IdImages read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IdImages()
      ..id = fields[0] as String
      ..lengthImgs = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, IdImages obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.lengthImgs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
