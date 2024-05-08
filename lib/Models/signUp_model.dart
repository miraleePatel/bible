class LoginSuccessModel {
  int? status;
  String? message;
  Data? data;

  LoginSuccessModel({this.status, this.message, this.data});

  LoginSuccessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? sId;
  String? userName;
  String? email;
  String? mobileNo;
  String? profileImage;
  String? location;
  String? dateOfBirth;
  String? socialMedia;
  String? token;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.userName,
      this.email,
      this.mobileNo,
      this.profileImage,
      this.location,
      this.dateOfBirth,
      this.socialMedia,
      this.token,
      this.fcmToken,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    profileImage = json['profile_image'];
    location = json['location'];
    dateOfBirth = json['dateOfBirth'];
    socialMedia = json['social_media'];
    token = json['token'];
    fcmToken = json['fcmToken'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['profile_image'] = this.profileImage;
    data['location'] = this.location;
    data['dateOfBirth'] = this.dateOfBirth;
    data['social_media'] = this.socialMedia;
    data['token'] = this.token;
    data['fcmToken'] = this.fcmToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
