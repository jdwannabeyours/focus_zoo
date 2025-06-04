// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FocusTypeAdapter extends TypeAdapter<FocusType> {
  @override
  final int typeId = 1;

  @override
  FocusType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FocusType.productive;
      case 1:
        return FocusType.relax;
      default:
        return FocusType.productive;
    }
  }

  @override
  void write(BinaryWriter writer, FocusType obj) {
    switch (obj) {
      case FocusType.productive:
        writer.writeByte(0);
        break;
      case FocusType.relax:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FocusTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
