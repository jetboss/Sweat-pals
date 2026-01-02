// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 10;

  @override
  Exercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercise(
      name: fields[0] as String,
      durationSeconds: fields[1] as int,
      reps: fields[2] as int,
      instructions: fields[3] as String,
      imageUrl: fields[4] as String?,
      lottieUrl: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.durationSeconds)
      ..writeByte(2)
      ..write(obj.reps)
      ..writeByte(3)
      ..write(obj.instructions)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.lottieUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutAdapter extends TypeAdapter<Workout> {
  @override
  final int typeId = 11;

  @override
  Workout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Workout(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      exercises: (fields[3] as List).cast<Exercise>(),
      category: fields[4] as String,
      imageUrl: fields[5] as String?,
      level: fields[6] as WorkoutLevel,
      durationMinutes: fields[7] as int,
      equipment: fields[8] as Equipment,
      workoutCategory: fields[9] as WorkoutCategory,
      unlockRequirement: fields[10] as int,
      unlockWorkoutId: fields[11] as String?,
      isChallenge: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Workout obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.exercises)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.level)
      ..writeByte(7)
      ..write(obj.durationMinutes)
      ..writeByte(8)
      ..write(obj.equipment)
      ..writeByte(9)
      ..write(obj.workoutCategory)
      ..writeByte(10)
      ..write(obj.unlockRequirement)
      ..writeByte(11)
      ..write(obj.unlockWorkoutId)
      ..writeByte(12)
      ..write(obj.isChallenge);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutSessionAdapter extends TypeAdapter<WorkoutSession> {
  @override
  final int typeId = 12;

  @override
  WorkoutSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutSession(
      workoutId: fields[0] as String,
      completedAt: fields[1] as DateTime,
      totalDurationSeconds: fields[2] as int,
      notes: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutSession obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.workoutId)
      ..writeByte(1)
      ..write(obj.completedAt)
      ..writeByte(2)
      ..write(obj.totalDurationSeconds)
      ..writeByte(3)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutLevelAdapter extends TypeAdapter<WorkoutLevel> {
  @override
  final int typeId = 13;

  @override
  WorkoutLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WorkoutLevel.beginner;
      case 1:
        return WorkoutLevel.intermediate;
      case 2:
        return WorkoutLevel.advanced;
      default:
        return WorkoutLevel.beginner;
    }
  }

  @override
  void write(BinaryWriter writer, WorkoutLevel obj) {
    switch (obj) {
      case WorkoutLevel.beginner:
        writer.writeByte(0);
        break;
      case WorkoutLevel.intermediate:
        writer.writeByte(1);
        break;
      case WorkoutLevel.advanced:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EquipmentAdapter extends TypeAdapter<Equipment> {
  @override
  final int typeId = 14;

  @override
  Equipment read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Equipment.none;
      case 1:
        return Equipment.dumbbells;
      case 2:
        return Equipment.resistanceBands;
      case 3:
        return Equipment.gym;
      default:
        return Equipment.none;
    }
  }

  @override
  void write(BinaryWriter writer, Equipment obj) {
    switch (obj) {
      case Equipment.none:
        writer.writeByte(0);
        break;
      case Equipment.dumbbells:
        writer.writeByte(1);
        break;
      case Equipment.resistanceBands:
        writer.writeByte(2);
        break;
      case Equipment.gym:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutCategoryAdapter extends TypeAdapter<WorkoutCategory> {
  @override
  final int typeId = 15;

  @override
  WorkoutCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WorkoutCategory.fullBody;
      case 1:
        return WorkoutCategory.upper;
      case 2:
        return WorkoutCategory.lower;
      case 3:
        return WorkoutCategory.core;
      case 4:
        return WorkoutCategory.hiit;
      case 5:
        return WorkoutCategory.mobility;
      case 6:
        return WorkoutCategory.challenge;
      default:
        return WorkoutCategory.fullBody;
    }
  }

  @override
  void write(BinaryWriter writer, WorkoutCategory obj) {
    switch (obj) {
      case WorkoutCategory.fullBody:
        writer.writeByte(0);
        break;
      case WorkoutCategory.upper:
        writer.writeByte(1);
        break;
      case WorkoutCategory.lower:
        writer.writeByte(2);
        break;
      case WorkoutCategory.core:
        writer.writeByte(3);
        break;
      case WorkoutCategory.hiit:
        writer.writeByte(4);
        break;
      case WorkoutCategory.mobility:
        writer.writeByte(5);
        break;
      case WorkoutCategory.challenge:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
