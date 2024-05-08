class GetPublicNoteModel {
  int? status;
  String? message;
  List<PublicData>? data;
  int? count;
  int? perPage;
  int? page;
  int? paginationValue;

  GetPublicNoteModel({this.status, this.message, this.data, this.count, this.perPage, this.page, this.paginationValue});

  GetPublicNoteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PublicData>[];
      json['data'].forEach((v) {
        data!.add(new PublicData.fromJson(v));
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

class PublicData {
  String? sId;
  String? verseKey;
  String? note;
  UserId? userId;
  bool? private;
  int? numberOfLikes;
  bool? like;

  PublicData({this.sId, this.verseKey, this.note, this.userId, this.private, this.numberOfLikes, this.like});

  PublicData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    verseKey = json['verse_key'];
    note = json['note'];
    userId = json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    private = json['private'];
    numberOfLikes = json['number_of_likes'];
    like = json['like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['verse_key'] = this.verseKey;
    data['note'] = this.note;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    data['private'] = this.private;
    data['number_of_likes'] = this.numberOfLikes;
    data['like'] = this.like;
    return data;
  }
}

class UserId {
  String? sId;
  String? userName;
  String? profileImage;

  UserId({this.sId, this.userName, this.profileImage});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
