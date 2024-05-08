class GetBookmarkModel {
  int? status;
  String? message;
  List<BookmarkData>? data;
  int? count;
  int? perPage;
  int? page;
  int? paginationValue;

  GetBookmarkModel(
      {this.status,
        this.message,
        this.data,
        this.count,
        this.perPage,
        this.page,
        this.paginationValue});

  GetBookmarkModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BookmarkData>[];
      json['data'].forEach((v) {
        data!.add(new BookmarkData.fromJson(v));
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

class BookmarkData {
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

  BookmarkData(
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

  BookmarkData.fromJson(Map<String, dynamic> json) {
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
