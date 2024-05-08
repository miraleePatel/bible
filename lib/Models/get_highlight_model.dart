class GetHighlightModel {
  int? status;
  String? message;
  List<HighlightData>? data;
  int? count;
  int? perPage;
  int? page;
  int? paginationValue;

  GetHighlightModel(
      {this.status,
        this.message,
        this.data,
        this.count,
        this.perPage,
        this.page,
        this.paginationValue});

  GetHighlightModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HighlightData>[];
      json['data'].forEach((v) {
        data!.add(new HighlightData.fromJson(v));
      });
    }
    count = json['count'];
    perPage = json['perPage'];
    page = json['page'];
    paginationValue = json['paginationValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['perPage'] = this.perPage;
    data['page'] = this.page;
    data['paginationValue'] = this.paginationValue;
    return data;
  }
}

class HighlightData {
  HighlightVerse? verse;
  String? color;
  String? sId;

  HighlightData({this.verse, this.color, this.sId});

  HighlightData.fromJson(Map<String, dynamic> json) {
    verse = json['verse'] != null ? new HighlightVerse.fromJson(json['verse']) : null;
    color = json['color'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.verse != null) {
      data['verse'] = this.verse!.toJson();
    }
    data['color'] = this.color;
    data['_id'] = this.sId;
    return data;
  }
}

class HighlightVerse {
  String? sId;
  String? key;
  String? verseKey;
  String? bookId;
  String? bookName;
  String? testament;
  String? bookGroup;
  int? chapterNo;
  int? verseNo;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? verseText;

  HighlightVerse(
      {this.sId,
        this.key,
        this.verseKey,
        this.bookId,
        this.bookName,
        this.testament,
        this.bookGroup,
        this.chapterNo,
        this.verseNo,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.verseText});

  HighlightVerse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    key = json['key'];
    verseKey = json['verse_key'];
    bookId = json['book_id'];
    bookName = json['book_name'];
    testament = json['testament'];
    bookGroup = json['book_group'];
    chapterNo = json['chapter_no'];
    verseNo = json['verse_no'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    verseText = json['verse_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['key'] = this.key;
    data['verse_key'] = this.verseKey;
    data['book_id'] = this.bookId;
    data['book_name'] = this.bookName;
    data['testament'] = this.testament;
    data['book_group'] = this.bookGroup;
    data['chapter_no'] = this.chapterNo;
    data['verse_no'] = this.verseNo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    data['verse_text'] = this.verseText;
    return data;
  }
}
