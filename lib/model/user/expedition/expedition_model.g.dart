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
    return Expedition()
      ..list = (fields[0] as List).cast<ExpeditionContent>()
      ..recentInitDateTime = fields[1] as DateTime
      ..nextWednesday = fields[2] as DateTime
      ..possibleGoldCharacters =
          fields[3] == null ? [] : (fields[3] as List).cast<String>();
  }

  @override
  void write(BinaryWriter writer, Expedition obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.list)
      ..writeByte(1)
      ..write(obj.recentInitDateTime)
      ..writeByte(2)
      ..write(obj.nextWednesday)
      ..writeByte(3)
      ..write(obj.possibleGoldCharacters);
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
