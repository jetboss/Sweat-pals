// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 0;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      name: fields[0] as String,
      startingWeight: fields[1] as double,
      targetWeight: fields[2] as double,
      height: fields[3] as double,
      age: fields[4] as int,
      sex: fields[5] as String,
      foodsToAvoid: fields[6] as String,
      startDate: fields[7] as DateTime,
      preferredWorkoutHour: fields[8] as int?,
      fitnessLevel: fields[9] as String?,
      bio: fields[10] as String?,
      restTokens: fields[11] as int?,
      sweatCoins: fields[12] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.startingWeight)
      ..writeByte(2)
      ..write(obj.targetWeight)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.age)
      ..writeByte(5)
      ..write(obj.sex)
      ..writeByte(6)
      ..write(obj.foodsToAvoid)
      ..writeByte(7)
      ..write(obj.startDate)
      ..writeByte(8)
      ..write(obj.preferredWorkoutHour)
      ..writeByte(9)
      ..write(obj.fitnessLevel)
      ..writeByte(10)
      ..write(obj.bio)
      ..writeByte(11)
      ..write(obj.restTokens)
      ..writeByte(12)
      ..write(obj.sweatCoins);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
