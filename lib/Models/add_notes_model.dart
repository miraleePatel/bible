class AddNoteModel {
  int? status;
  String? message;
  NoteData? data;

  AddNoteModel({this.status, this.message, this.data});

  AddNoteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new NoteData.fromJson(json['data']) : null;
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

class NoteData {
  String? verseKey;
  VerseDetail? verseDetail;
  String? note;
  String? userId;
  String? commentId;
  bool? private;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NoteData(
      {this.verseKey,
        this.verseDetail,
        this.note,
        this.userId,
        this.commentId,
        this.private,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  NoteData.fromJson(Map<String, dynamic> json) {
    verseKey = json['verse_key'];
    verseDetail = json['verse_detail'] != null
        ? new VerseDetail.fromJson(json['verse_detail'])
        : null;
    note = json['note'];
    userId = json['user_id'];
    commentId = json['comment_id'];
    private = json['private'];
    sId = json['_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verse_key'] = this.verseKey;
    if (this.verseDetail != null) {
      data['verse_detail'] = this.verseDetail!.toJson();
    }
    data['note'] = this.note;
    data['user_id'] = this.userId;
    data['comment_id'] = this.commentId;
    data['private'] = this.private;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class VerseDetail {
  String? bookId;
  String? bookName;
  int? chapter;
  int? verse;

  VerseDetail({this.bookId, this.bookName, this.chapter, this.verse});

  VerseDetail.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    bookName = json['book_name'];
    chapter = json['chapter'];
    verse = json['verse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['book_name'] = this.bookName;
    data['chapter'] = this.chapter;
    data['verse'] = this.verse;
    return data;
  }
}
