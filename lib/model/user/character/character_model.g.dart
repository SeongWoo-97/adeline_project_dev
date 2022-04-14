// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 2;

  @override
  Character read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Character(
      server: fields[1] as String,
      nickName: fields[0] as String,
      level: fields[4] as dynamic,
      job: fields[5] as dynamic,
      jobCode: fields[3] as String,
    )
      ..groupName = fields[2] as String
      ..dailyContents = (fields[6] as List).cast<dynamic>()
      ..weeklyContents = (fields[7] as List).cast<WeeklyContent>()
      ..goldContents = (fields[8] as List).cast<GoldContent>();
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.nickName)
      ..writeByte(1)
      ..write(obj.server)
      ..writeByte(2)
      ..write(obj.groupName)
      ..writeByte(3)
      ..write(obj.jobCode)
      ..writeByte(4)
      ..write(obj.level)
      ..writeByte(5)
      ..write(obj.job)
      ..writeByte(6)
      ..write(obj.dailyContents)
      ..writeByte(7)
      ..write(obj.weeklyContents)
      ..writeByte(8)
      ..write(obj.goldContents);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
