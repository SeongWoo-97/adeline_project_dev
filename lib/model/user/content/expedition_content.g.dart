// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expedition_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpeditionContentAdapter extends TypeAdapter<ExpeditionContent> {
  @override
  final int typeId = 7;

  @override
  ExpeditionContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpeditionContent(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    )
      ..clearCheck = fields[3] as bool
      ..isChecked = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, ExpeditionContent obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.iconName)
      ..writeByte(3)
      ..write(obj.clearCheck)
      ..writeByte(4)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpeditionContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
