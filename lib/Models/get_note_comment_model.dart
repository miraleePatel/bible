class GetNoteCommentModel {
  int? status;
  String? message;
  List<GetCommentData>? data;
  int? count;
  int? perPage;
  int? page;
  int? paginationValue;

  GetNoteCommentModel(
      {this.status,
        this.message,
        this.data,
        this.count,
        this.perPage,
        this.page,
        this.paginationValue});

  GetNoteCommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetCommentData>[];
      json['data'].forEach((v) {
        data!.add(new GetCommentData.fromJson(v));
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

class GetCommentData {
  String? sId;
  String? noteId;
  String? comment;
  UserId? userId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  GetCommentData(
      {this.sId,
        this.noteId,
        this.comment,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  GetCommentData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    noteId = json['note_id'];
    comment = json['comment'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['note_id'] = this.noteId;
    data['comment'] = this.comment;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
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
