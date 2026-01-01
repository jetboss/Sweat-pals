// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_photo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgressPhotoAdapter extends TypeAdapter<ProgressPhoto> {
  @override
  final int typeId = 21;

  @override
  ProgressPhoto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgressPhoto(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      imagePath: fields[2] as String,
      weight: fields[3] as double?,
      notes: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProgressPhoto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressPhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
