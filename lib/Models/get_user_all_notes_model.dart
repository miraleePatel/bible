class GetUserAllNotesModel {
  int? status;
  String? message;
  List<UserNotesData>? data;

  GetUserAllNotesModel({this.status, this.message, this.data});

  GetUserAllNotesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserNotesData>[];
      json['data'].forEach((v) {
        data!.add(new UserNotesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserNotesData {
  String? sId;
  String? verseKey;
  VerseId? verseId;
  String? note;
  UserId? userId;
  bool? private;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserNotesData(
      {this.sId,
        this.verseKey,
        this.verseId,
        this.note,
        this.userId,
        this.private,
        this.createdAt,
        this.updatedAt,
        this.iV});

  UserNotesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    verseKey = json['verse_key'];
    verseId = json['verse_id'] != null
        ? new VerseId.fromJson(json['verse_id'])
        : null;
    note = json['note'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    private = json['private'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['verse_key'] = this.verseKey;
    if (this.verseId != null) {
      data['verse_id'] = this.verseId!.toJson();
    }
    data['note'] = this.note;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    data['private'] = this.private;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class VerseId {
  String? sId;
  String? verseText;

  VerseId({this.sId, this.verseText});

  VerseId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    verseText = json['verse_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['verse_text'] = this.verseText;
    return data;
  }}

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
