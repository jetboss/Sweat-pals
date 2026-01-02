// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_workout.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduledWorkoutAdapter extends TypeAdapter<ScheduledWorkout> {
  @override
  final int typeId = 17;

  @override
  ScheduledWorkout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduledWorkout(
      id: fields[0] as String,
      workoutId: fields[1] as String,
      scheduledDate: fields[2] as DateTime,
      isCompleted: fields[3] as bool,
      completedAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduledWorkout obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.workoutId)
      ..writeByte(2)
      ..write(obj.scheduledDate)
      ..writeByte(3)
      ..write(obj.isCompleted)
      ..writeByte(4)
      ..write(obj.completedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduledWorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
