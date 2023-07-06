// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeDataAdapter extends TypeAdapter<HomeData> {
  @override
  final int typeId = 3;

  @override
  HomeData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeData(
      homeNum: fields[0] as int,
      price: fields[1] as int,
      isBought: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HomeData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.homeNum)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.isBought);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
