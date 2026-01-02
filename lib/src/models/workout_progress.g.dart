// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutProgressAdapter extends TypeAdapter<WorkoutProgress> {
  @override
  final int typeId = 16;

  @override
  WorkoutProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutProgress(
      completionCounts: (fields[0] as Map).cast<String, int>(),
      unlockedWorkoutIds: (fields[1] as List).cast<String>(),
      lastWorkoutDate: fields[2] as DateTime?,
      currentStreak: fields[3] as int,
      longestStreak: fields[4] as int,
      totalWorkoutsCompleted: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutProgress obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.completionCounts)
      ..writeByte(1)
      ..write(obj.unlockedWorkoutIds)
      ..writeByte(2)
      ..write(obj.lastWorkoutDate)
      ..writeByte(3)
      ..write(obj.currentStreak)
      ..writeByte(4)
      ..write(obj.longestStreak)
      ..writeByte(5)
      ..write(obj.totalWorkoutsCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
