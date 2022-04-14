// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expedition_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpeditionAdapter extends TypeAdapter<Expedition> {
  @override
  final int typeId = 8;

  @override
  Expedition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expedition()..list = (fields[0] as List).cast<ExpeditionContent>();
  }

  @override
  void write(BinaryWriter writer, Expedition obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpeditionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
