class VerseCommentModel {
  int? status;
  String? message;
  VerseCommentData? data;

  VerseCommentModel({this.status, this.message, this.data});

  VerseCommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new VerseCommentData.fromJson(json['data']) : null;
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

class VerseCommentData {
  List<CommentData>? comment;
  List<VideoData>? video;

  VerseCommentData({this.comment, this.video});

  VerseCommentData.fromJson(Map<String, dynamic> json) {
    if (json['comment'] != null) {
      comment = <CommentData>[];
      json['comment'].forEach((v) {
        comment!.add(new CommentData.fromJson(v));
      });
    }
    if (json['video'] != null) {
      video = <VideoData>[];
      json['video'].forEach((v) {
        video!.add(new VideoData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v.toJson()).toList();
    }
    if (this.video != null) {
      data['video'] = this.video!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentData {
  String? sId;
  String? verseId;
  String? verseKey;
  String? comment;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<CommentNotes>? notes;

  CommentData(
      {this.sId,
        this.verseId,
        this.verseKey,
        this.comment,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.notes});

  CommentData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    verseId = json['verse_id'];
    verseKey = json['verse_key'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    if (json['notes'] != null) {
      notes = <CommentNotes>[];
      json['notes'].forEach((v) {
        notes!.add(new CommentNotes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['verse_id'] = this.verseId;
    data['verse_key'] = this.verseKey;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.notes != null) {
      data['notes'] = this.notes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentNotes {
  String? sId;
  String? verseKey;
  String? verseId;
  String? note;
  UserId? userId;
  String? commentId;
  bool? private;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CommentNotes(
      {this.sId,
        this.verseKey,
        this.verseId,
        this.note,
        this.userId,
        this.commentId,
        this.private,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CommentNotes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    verseKey = json['verse_key'];
    verseId = json['verse_id'];
    note = json['note'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    commentId = json['comment_id'];
    private = json['private'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['verse_key'] = this.verseKey;
    data['verse_id'] = this.verseId;
    data['note'] = this.note;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    data['comment_id'] = this.commentId;
    data['private'] = this.private;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
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

class VideoData {
  String? sId;
  String? verseId;
  String? verseKey;
  String? videoLink;
  String? createdAt;
  String? updatedAt;
  int? iV;

  VideoData(
      {this.sId,
        this.verseId,
        this.verseKey,
        this.videoLink,
        this.createdAt,
        this.updatedAt,
        this.iV});

  VideoData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    verseId = json['verse_id'];
    verseKey = json['verse_key'];
    videoLink = json['video_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['verse_id'] = this.verseId;
    data['verse_key'] = this.verseKey;
    data['video_link'] = this.videoLink;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
