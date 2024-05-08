// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BibleModelAdapter extends TypeAdapter<BibleModel> {
  @override
  final int typeId = 0;

  @override
  BibleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BibleModel(
      status: fields[0] as int?,
      message: fields[1] as String?,
      data: fields[2] as BibleData?,
    );
  }

  @override
  void write(BinaryWriter writer, BibleModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BibleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BibleDataAdapter extends TypeAdapter<BibleData> {
  @override
  final int typeId = 1;

  @override
  BibleData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BibleData(
      oldTestament: (fields[0] as List?)?.cast<OldTestament>(),
      newTestament: (fields[1] as List?)?.cast<OldTestament>(),
    );
  }

  @override
  void write(BinaryWriter writer, BibleData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.oldTestament)
      ..writeByte(1)
      ..write(obj.newTestament);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BibleDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OldTestamentAdapter extends TypeAdapter<OldTestament> {
  @override
  final int typeId = 2;

  @override
  OldTestament read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OldTestament(
      sId: fields[0] as String?,
      bookId: fields[1] as String?,
      name: fields[2] as String?,
      testament: fields[3] as String?,
      testamentOrder: fields[4] as int?,
      bookGroup: fields[5] as String?,
      chapters: (fields[6] as List?)?.cast<Chapters>(),
    );
  }

  @override
  void write(BinaryWriter writer, OldTestament obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.bookId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.testament)
      ..writeByte(4)
      ..write(obj.testamentOrder)
      ..writeByte(5)
      ..write(obj.bookGroup)
      ..writeByte(6)
      ..write(obj.chapters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OldTestamentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChaptersAdapter extends TypeAdapter<Chapters> {
  @override
  final int typeId = 3;

  @override
  Chapters read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chapters(
      chapterNo: fields[0] as int?,
      verse: (fields[1] as List?)?.cast<Verse>(),
      sId: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Chapters obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.chapterNo)
      ..writeByte(1)
      ..write(obj.verse)
      ..writeByte(2)
      ..write(obj.sId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChaptersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VerseAdapter extends TypeAdapter<Verse> {
  @override
  final int typeId = 4;

  @override
  Verse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Verse(
      key: fields[0] as int?,
      verseKey: fields[1] as String?,
      verseText: fields[2] as String?,
      sId: fields[3] as String?,
      verseNo: fields[4] as String?,
      comment: (fields[5] as List?)?.cast<Comment>(),
      videoComment: (fields[6] as List?)?.cast<VideoComment>(),
    );
  }

  @override
  void write(BinaryWriter writer, Verse obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.verseKey)
      ..writeByte(2)
      ..write(obj.verseText)
      ..writeByte(3)
      ..write(obj.sId)
      ..writeByte(4)
      ..write(obj.verseNo)
      ..writeByte(5)
      ..write(obj.comment)
      ..writeByte(6)
      ..write(obj.videoComment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  final int typeId = 5;

  @override
  Comment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comment(
      sId: fields[0] as String?,
      comment: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoCommentAdapter extends TypeAdapter<VideoComment> {
  @override
  final int typeId = 6;

  @override
  VideoComment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoComment(
      sId: fields[0] as String?,
      videoLink: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VideoComment obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.videoLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoCommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
