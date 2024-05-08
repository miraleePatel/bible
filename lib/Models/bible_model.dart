import 'package:bible_app/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

/*part 'bible_model.g.dart';

@HiveType(typeId: 0, adapterName: 'BibleModelAdapter')
class BibleModel extends HiveObject {
  @HiveField(0)
  int? status;
  @HiveField(1)
  String? message;
  @HiveField(2)
  List<BibleData>? bibleData;

  BibleModel({this.status, this.message, this.bibleData});

  BibleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      bibleData = <BibleData>[];
      json['data'].forEach((v) {
        bibleData!.add(BibleData.fromJson(v));
      });
    }
  }

*//*   BibleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      bibleData = [];
      if (json['data'] is List) {
        // Assuming 'data' is a List
        (json['data'] as List).forEach((v) {
          bibleData!.add(BibleData.fromJson(v));
        });
      }
    }
  } *//*

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.bibleData != null) {
      data['data'] = this.bibleData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 1, adapterName: 'BibleDataAdapter')
class BibleData extends HiveObject {
  @HiveField(0)
  String? sId;
  @HiveField(1)
  String? bookId;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? testament;
  @HiveField(4)
  int? testamentOrder;
  @HiveField(5)
  String? bookGroup;
  @HiveField(6)
  List<Chapters>? chapters;

  BibleData({this.sId, this.bookId, this.name, this.testament, this.testamentOrder, this.bookGroup, this.chapters});

  BibleData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bookId = json['book_id'];
    name = json['name'];
    testament = json['testament'];
    testamentOrder = json['testament_order'];
    bookGroup = json['book_group'];
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['book_id'] = this.bookId;
    data['name'] = this.name;
    data['testament'] = this.testament;
    data['testament_order'] = this.testamentOrder;
    data['book_group'] = this.bookGroup;
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 2, adapterName: 'ChaptersAdapter')
class Chapters extends HiveObject {
  @HiveField(0)
  int? chapterNo;
  @HiveField(1)
  List<Verse>? verse;
  @HiveField(2)
  String? sId;

  Chapters({this.chapterNo, this.verse, this.sId});

  Chapters.fromJson(Map<String, dynamic> json) {
    chapterNo = json['chapter_no'];
    if (json['verse'] != null) {
      verse = <Verse>[];
      json['verse'].forEach((v) {
        verse!.add(Verse.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['chapter_no'] = this.chapterNo;
    if (this.verse != null) {
      data['verse'] = this.verse!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    return data;
  }
}

@HiveType(typeId: 3, adapterName: 'VerseAdapter')
class Verse extends HiveObject {
  @HiveField(0)
  int? key;
  @HiveField(1)
  String? verseKey;
  @HiveField(2)
  String? verseText;
  @HiveField(3)
  String? sId;
  @HiveField(4)
  String? verseNo;
  @HiveField(5)
  List<Comment>? comment;
  @HiveField(6)
  Color? selectColor;

  Verse({this.key, this.verseKey, this.verseText, this.sId, this.verseNo, this.comment, this.selectColor});

  Verse.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    verseKey = json['verseKey'];
    verseText = json['verse_text'];
    sId = json['_id'];
    verseNo = json['verse_no'];
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(Comment.fromJson(v));
      });
    }
    selectColor = json['select_color'] ?? AppColors.yellowColor;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['key'] = this.key;
    data['verseKey'] = this.verseKey;
    data['verse_text'] = this.verseText;
    data['_id'] = this.sId;
    data['verse_no'] = this.verseNo;
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v.toJson()).toList();
    }
    data['select_color'] = this.selectColor;
    return data;
  }
}

@HiveType(typeId: 4, adapterName: 'CommentAdapter')
class Comment extends HiveObject {
  @HiveField(0)
  String? sId;
  @HiveField(1)
  String? comment;

  Comment({this.sId, this.comment});

  Comment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['comment'] = this.comment;
    return data;
  }
}*/

part 'bible_model.g.dart';

@HiveType(typeId: 0, adapterName: 'BibleModelAdapter')
class BibleModel extends HiveObject{
  @HiveField(0)
  int? status;
  @HiveField(1)
  String? message;
  @HiveField(2)
  BibleData? data;

  BibleModel({this.status, this.message, this.data});

  BibleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new BibleData.fromJson(json['data']) : null;
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

@HiveType(typeId: 1, adapterName: 'BibleDataAdapter')
class BibleData extends HiveObject{
  @HiveField(0)
  List<OldTestament>? oldTestament;
  @HiveField(1)
  List<OldTestament>? newTestament;

  BibleData({this.oldTestament, this.newTestament});

  BibleData.fromJson(Map<String, dynamic> json) {
    if (json['oldTestament'] != null) {
      oldTestament = <OldTestament>[];
      json['oldTestament'].forEach((v) {
        oldTestament!.add(new OldTestament.fromJson(v));
      });
    }
    if (json['newTestament'] != null) {
      newTestament = <OldTestament>[];
      json['newTestament'].forEach((v) {
        newTestament!.add(new OldTestament.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.oldTestament != null) {
      data['oldTestament'] = this.oldTestament!.map((v) => v.toJson()).toList();
    }
    if (this.newTestament != null) {
      data['newTestament'] = this.newTestament!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


@HiveType(typeId: 2, adapterName: 'OldTestamentAdapter')
class OldTestament extends HiveObject{
  @HiveField(0)
  String? sId;
  @HiveField(1)
  String? bookId;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? testament;
  @HiveField(4)
  int? testamentOrder;
  @HiveField(5)
  String? bookGroup;
  @HiveField(6)
  List<Chapters>? chapters;

  OldTestament(
      {this.sId,
        this.bookId,
        this.name,
        this.testament,
        this.testamentOrder,
        this.bookGroup,
        this.chapters});

  OldTestament.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bookId = json['book_id'];
    name = json['name'];
    testament = json['testament'];
    testamentOrder = json['testament_order'];
    bookGroup = json['book_group'];
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
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
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 3, adapterName: 'ChaptersAdapter')
class Chapters extends HiveObject {
  @HiveField(0)
  int? chapterNo;
  @HiveField(1)
  List<Verse>? verse;
  @HiveField(2)
  String? sId;

  Chapters({this.chapterNo, this.verse, this.sId});

  Chapters.fromJson(Map<String, dynamic> json) {
    chapterNo = json['chapter_no'];
    if (json['verse'] != null) {
      verse = <Verse>[];
      json['verse'].forEach((v) {
        verse!.add(Verse.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['chapter_no'] = this.chapterNo;
    if (this.verse != null) {
      data['verse'] = this.verse!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    return data;
  }
}


@HiveType(typeId: 4, adapterName: 'VerseAdapter')
class Verse extends HiveObject {
  @HiveField(0)
  int? key;
  @HiveField(1)
  String? verseKey;
  @HiveField(2)
  String? verseText;
  @HiveField(3)
  String? sId;
  @HiveField(4)
  String? verseNo;
  @HiveField(5)
  List<Comment>? comment;
  @HiveField(6)
  List<VideoComment>? videoComment;


  Verse({this.key, this.verseKey, this.verseText, this.sId, this.verseNo, this.comment,this.videoComment});

  Verse.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    verseKey = json['verseKey'];
    verseText = json['verse_text'];
    sId = json['_id'];
    verseNo = json['verse_no'];
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(Comment.fromJson(v));
      });
    }
    if (json['video_comment'] != null) {
      videoComment = <VideoComment>[];
      json['video_comment'].forEach((v) {
        videoComment!.add(new VideoComment.fromJson(v));
      });
    }
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['key'] = this.key;
    data['verseKey'] = this.verseKey;
    data['verse_text'] = this.verseText;
    data['_id'] = this.sId;
    data['verse_no'] = this.verseNo;
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v.toJson()).toList();
    }  if (this.videoComment != null) {
      data['video_comment'] = this.videoComment!.map((v) => v.toJson()).toList();
    }
     return data;
  }
}


@HiveType(typeId: 5, adapterName: 'CommentAdapter')
class Comment extends HiveObject {
  @HiveField(0)
  String? sId;
  @HiveField(1)
  String? comment;

  Comment({this.sId, this.comment});

  Comment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['comment'] = this.comment;
    return data;
  }
}

@HiveType(typeId: 6, adapterName: 'VideoCommentAdapter')
class VideoComment extends HiveObject{
  @HiveField(0)
  String? sId;
  @HiveField(1)
  String? videoLink;

  VideoComment({this.sId, this.videoLink});

  VideoComment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    videoLink = json['video_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['video_link'] = this.videoLink;
    return data;
  }
}

