class SearchVerseModel {
  int? status;
  String? message;
  SearchData? data;

  SearchVerseModel({this.status, this.message, this.data});

  SearchVerseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new SearchData.fromJson(json['data']) : null;
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

class SearchData {
  List<SearchVerseData>? data;
  Meta? meta;

  SearchData({this.data, this.meta});

  SearchData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SearchVerseData>[];
      json['data'].forEach((v) {
        data!.add(new SearchVerseData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class SearchVerseData {
  String? bookId;
  String? bookName;
  String? bookNameAlt;
  int? chapter;
  String? chapterAlt;
  int? verseStart;
  String? verseStartAlt;
  int? verseEnd;
  String? verseEndAlt;
  String? verseText;

  SearchVerseData(
      {this.bookId,
        this.bookName,
        this.bookNameAlt,
        this.chapter,
        this.chapterAlt,
        this.verseStart,
        this.verseStartAlt,
        this.verseEnd,
        this.verseEndAlt,
        this.verseText});

  SearchVerseData.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    bookName = json['book_name'];
    bookNameAlt = json['book_name_alt'];
    chapter = json['chapter'];
    chapterAlt = json['chapter_alt'];
    verseStart = json['verse_start'];
    verseStartAlt = json['verse_start_alt'];
    verseEnd = json['verse_end'];
    verseEndAlt = json['verse_end_alt'];
    verseText = json['verse_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['book_name'] = this.bookName;
    data['book_name_alt'] = this.bookNameAlt;
    data['chapter'] = this.chapter;
    data['chapter_alt'] = this.chapterAlt;
    data['verse_start'] = this.verseStart;
    data['verse_start_alt'] = this.verseStartAlt;
    data['verse_end'] = this.verseEnd;
    data['verse_end_alt'] = this.verseEndAlt;
    data['verse_text'] = this.verseText;
    return data;
  }
}

class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;
  Links? links;

  Pagination(
      {this.total,
        this.count,
        this.perPage,
        this.currentPage,
        this.totalPages,
        this.links});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Links {
  String? next;

  Links({this.next});

  Links.fromJson(Map<String, dynamic> json) {
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    return data;
  }
}
