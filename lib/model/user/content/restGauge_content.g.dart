// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restGauge_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestGaugeContentAdapter extends TypeAdapter<RestGaugeContent> {
  @override
  final int typeId = 6;

  @override
  RestGaugeContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RestGaugeContent(
      fields[0] as String,
      fields[1] as String,
      fields[5] as int,
      fields[2] as bool,
    )
      ..clearCheck = fields[3] as bool
      ..clearNum = fields[4] as int
      ..restGauge = fields[6] as int
      ..lateRevision = fields[7] as DateTime
      ..saveRestGauge = fields[8] as int
      ..saveLateRevision = fields[9] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, RestGaugeContent obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.iconName)
      ..writeByte(2)
      ..write(obj.isChecked)
      ..writeByte(3)
      ..write(obj.clearCheck)
      ..writeByte(4)
      ..write(obj.clearNum)
      ..writeByte(5)
      ..write(obj.maxClearNum)
      ..writeByte(6)
      ..write(obj.restGauge)
      ..writeByte(7)
      ..write(obj.lateRevision)
      ..writeByte(8)
      ..write(obj.saveRestGauge)
      ..writeByte(9)
      ..write(obj.saveLateRevision);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestGaugeContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
