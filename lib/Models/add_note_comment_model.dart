class AddNoteCommentModel {
  int? status;
  String? message;
  NoteCommentData? data;

  AddNoteCommentModel({this.status, this.message, this.data});

  AddNoteCommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new NoteCommentData.fromJson(json['data']) : null;
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

class NoteCommentData {
  String? noteId;
  String? comment;
  String? userId;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NoteCommentData(
      {this.noteId,
        this.comment,
        this.userId,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  NoteCommentData.fromJson(Map<String, dynamic> json) {
    noteId = json['note_id'];
    comment = json['comment'];
    userId = json['user_id'];
    sId = json['_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note_id'] = this.noteId;
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
