// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gold_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoldContentAdapter extends TypeAdapter<GoldContent> {
  @override
  final int typeId = 5;

  @override
  GoldContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoldContent(
      type: fields[0] as String,
      name: fields[1] as String,
      totalPhase: fields[2] as int,
      enterLevelLimit: fields[3] as int,
      getGoldLevelLimit: fields[5] as int,
      levelLimitPerPhase: (fields[7] as List).cast<int>(),
      difficulty: fields[4] as String,
      goldPerPhase: (fields[6] as List).cast<int>(),
      clearGold: fields[8] as int,
      characterAlwaysMaxClear: fields[11] as bool,
    )
      ..addGold = fields[9] as int
      ..clearChecked = fields[10] as bool
      ..isChecked = fields[12] as bool;
  }

  @override
  void write(BinaryWriter writer, GoldContent obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.totalPhase)
      ..writeByte(3)
      ..write(obj.enterLevelLimit)
      ..writeByte(4)
      ..write(obj.difficulty)
      ..writeByte(5)
      ..write(obj.getGoldLevelLimit)
      ..writeByte(6)
      ..write(obj.goldPerPhase)
      ..writeByte(7)
      ..write(obj.levelLimitPerPhase)
      ..writeByte(8)
      ..write(obj.clearGold)
      ..writeByte(9)
      ..write(obj.addGold)
      ..writeByte(10)
      ..write(obj.clearChecked)
      ..writeByte(11)
      ..write(obj.characterAlwaysMaxClear)
      ..writeByte(12)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoldContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
