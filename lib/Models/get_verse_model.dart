import 'dart:ui';

import '../Utils/app_colors.dart';

class GetVerseModel {
  int? status;
  String? message;
  VerseData? data;

  GetVerseModel({this.status, this.message, this.data});

  GetVerseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new VerseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class VerseData {
  String? sId;
  String? bookId;
  String? name;
  String? testament;
  int? testamentOrder;
  String? bookGroup;
  filterChapters? chapters;

  VerseData({
    this.sId,
    this.bookId,
    this.name,
    this.testament,
    this.testamentOrder,
    this.bookGroup,
    this.chapters,
  });

  VerseData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bookId = json['book_id'];
    name = json['name'];
    testament = json['testament'];
    testamentOrder = json['testament_order'];
    bookGroup = json['book_group'];
    chapters = json['chapters'] != null ? new filterChapters.fromJson(json['chapters']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['book_id'] = this.bookId;
    data['name'] = this.name;
    data['testament'] = this.testament;
    data['testament_order'] = this.testamentOrder;
    data['book_group'] = this.bookGroup;
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.toJson();
    }

    return data;
  }
}

class filterChapters {
  int? chapterNo;
  String? sId;
  List<filterVerse>? verse;

  filterChapters({this.chapterNo, this.sId, this.verse});

  filterChapters.fromJson(Map<String, dynamic> json) {
    chapterNo = json['chapter_no'];
    sId = json['_id'];
    if (json['verse'] != null) {
      verse = <filterVerse>[];
      json['verse'].forEach((v) {
        verse!.add(new filterVerse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_no'] = this.chapterNo;
    data['_id'] = this.sId;
    if (this.verse != null) {
      data['verse'] = this.verse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class filterVerse {
  int? key;
  String? verseKey;
  String? verseNo;
  String? verseText;
  String? sId;
  Color? selectColor;

  filterVerse({this.key, this.verseKey, this.verseNo, this.verseText, this.sId, this.selectColor});

  filterVerse.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    verseKey = json['verseKey'];
    verseNo = json['verse_no'];
    verseText = json['verse_text'];
    sId = json['_id'];
    selectColor = json['select_color'] ?? AppColors.yellowColor;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['verseKey'] = this.verseKey;
    data['verse_no'] = this.verseNo;
    data['verse_text'] = this.verseText;
    data['_id'] = this.sId;
    data['select_color'] = this.selectColor;
    return data;
  }
}
