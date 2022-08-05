// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raid_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RaidContentAdapter extends TypeAdapter<RaidContent> {
  @override
  final int typeId = 5;

  @override
  RaidContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RaidContent(
      type: fields[0] as String,
      name: fields[1] as String,
      totalPhase: fields[2] as int,
      getGoldLevelLimit: fields[4] as int,
      difficulty: (fields[3] as List).cast<String>(),
      clearGold: fields[5] as int,
      reward: (fields[9] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as Map).cast<String, dynamic>())),
      clearList: (fields[10] as List).cast<CheckHistory>(),
      bonusList: (fields[11] as List).cast<CheckHistory>(),
      clearCheckStandardPhase: fields[12] as int,
    )
      ..addGold = fields[6] as int
      ..clearChecked = fields[7] as bool
      ..isChecked = fields[8] as bool
      ..minusGold = fields[13] == null ? 0 : fields[13] as int;
  }

  @override
  void write(BinaryWriter writer, RaidContent obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.totalPhase)
      ..writeByte(3)
      ..write(obj.difficulty)
      ..writeByte(4)
      ..write(obj.getGoldLevelLimit)
      ..writeByte(5)
      ..write(obj.clearGold)
      ..writeByte(6)
      ..write(obj.addGold)
      ..writeByte(7)
      ..write(obj.clearChecked)
      ..writeByte(8)
      ..write(obj.isChecked)
      ..writeByte(9)
      ..write(obj.reward)
      ..writeByte(10)
      ..write(obj.clearList)
      ..writeByte(11)
      ..write(obj.bonusList)
      ..writeByte(12)
      ..write(obj.clearCheckStandardPhase)
      ..writeByte(13)
      ..write(obj.minusGold);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RaidContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CheckHistoryAdapter extends TypeAdapter<CheckHistory> {
  @override
  final int typeId = 9;

  @override
  CheckHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckHistory(
      difficulty: fields[1] as String,
      check: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CheckHistory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.check)
      ..writeByte(1)
      ..write(obj.difficulty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
