// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entries.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntriesAdapter extends TypeAdapter<Entries> {
  @override
  final int typeId = 0;

  @override
  Entries read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Entries()
      ..email = fields[0] as String
      ..password = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Entries obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
