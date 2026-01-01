// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_check_in.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitCheckInAdapter extends TypeAdapter<HabitCheckIn> {
  @override
  final int typeId = 23;

  @override
  HabitCheckIn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitCheckIn(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      followedMealPlan: fields[2] as bool,
      mealPlanNotes: fields[3] as String,
      sleepHours: fields[4] as double,
      drankWater: fields[5] as bool,
      mood: fields[6] as int,
      exerciseCompleted: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HabitCheckIn obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.followedMealPlan)
      ..writeByte(3)
      ..write(obj.mealPlanNotes)
      ..writeByte(4)
      ..write(obj.sleepHours)
      ..writeByte(5)
      ..write(obj.drankWater)
      ..writeByte(6)
      ..write(obj.mood)
      ..writeByte(7)
      ..write(obj.exerciseCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitCheckInAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
