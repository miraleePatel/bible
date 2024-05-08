class FriendRequestModel {
  int? status;
  String? message;
  List<RequestData>? data;

  FriendRequestModel({this.status, this.message, this.data});

  FriendRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RequestData>[];
      json['data'].forEach((v) {
        data!.add(new RequestData.fromJson(v));
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

class RequestData {
  String? sId;
  SenderId? senderId;
  String? receiverId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RequestData(
      {this.sId,
        this.senderId,
        this.receiverId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  RequestData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderId = json['sender_id'] != null
        ? new SenderId.fromJson(json['sender_id'])
        : null;
    receiverId = json['receiver_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.senderId != null) {
      data['sender_id'] = this.senderId!.toJson();
    }
    data['receiver_id'] = this.receiverId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SenderId {
  String? sId;
  String? userName;
  String? email;
  String? profileImage;

  SenderId({this.sId, this.userName, this.email, this.profileImage});

  SenderId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
