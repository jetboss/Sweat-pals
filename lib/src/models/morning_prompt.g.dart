// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'morning_prompt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MorningPromptAdapter extends TypeAdapter<MorningPrompt> {
  @override
  final int typeId = 22;

  @override
  MorningPrompt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MorningPrompt(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      goalReminder: fields[2] as String,
      dailyAction: fields[3] as String,
      gratitude: fields[4] as String,
      affirmation: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MorningPrompt obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.goalReminder)
      ..writeByte(3)
      ..write(obj.dailyAction)
      ..writeByte(4)
      ..write(obj.gratitude)
      ..writeByte(5)
      ..write(obj.affirmation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MorningPromptAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
