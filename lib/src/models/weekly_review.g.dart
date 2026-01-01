// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_review.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeeklyReviewAdapter extends TypeAdapter<WeeklyReview> {
  @override
  final int typeId = 20;

  @override
  WeeklyReview read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyReview(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      weight: fields[2] as double,
      waist: fields[3] as double,
      consistencyScore: fields[4] as int,
      notes: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeeklyReview obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.waist)
      ..writeByte(4)
      ..write(obj.consistencyScore)
      ..writeByte(5)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyReviewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
