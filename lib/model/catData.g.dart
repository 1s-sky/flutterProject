// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatDataAdapter extends TypeAdapter<CatData> {
  @override
  final int typeId = 1;

  @override
  CatData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatData(
      maxCount: fields[0] as int,
      selectedImgNum: fields[1] as int,
      cat: (fields[2] as List).cast<String>(),
      visiability: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CatData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.maxCount)
      ..writeByte(1)
      ..write(obj.selectedImgNum)
      ..writeByte(2)
      ..write(obj.cat)
      ..writeByte(3)
      ..write(obj.visiability);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
