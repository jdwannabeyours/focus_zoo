// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlanHistoryAdapter extends TypeAdapter<PlanHistory> {
  @override
  final int typeId = 0;

  @override
  PlanHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlanHistory(
      topic: fields[0] as String,
      minutes: fields[1] as int,
      focusType: fields[2] as FocusType,
      success: fields[3] as bool,
      dateTime: fields[4] as DateTime,
      actualMinutes: fields[5] as int?,
      actualSeconds: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PlanHistory obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.topic)
      ..writeByte(1)
      ..write(obj.minutes)
      ..writeByte(2)
      ..write(obj.focusType)
      ..writeByte(3)
      ..write(obj.success)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.actualMinutes)
      ..writeByte(6)
      ..write(obj.actualSeconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
