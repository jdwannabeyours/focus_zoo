// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalAdapter extends TypeAdapter<Animal> {
  @override
  final int typeId = 2;

  @override
  Animal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal(
      id: fields[0] as String,
      type: fields[1] as String,
      variant: fields[2] as String,
      mood: fields[3] as String,
      unlocked: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Animal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.variant)
      ..writeByte(3)
      ..write(obj.mood)
      ..writeByte(4)
      ..write(obj.unlocked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
