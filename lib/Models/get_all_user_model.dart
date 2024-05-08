class GetAllUserModel {
  int? status;
  String? message;
  List<UserData>? data;
  int? count;
  int? perPage;
  int? page;
  int? paginationValue;

  GetAllUserModel(
      {this.status,
        this.message,
        this.data,
        this.count,
        this.perPage,
        this.page,
        this.paginationValue});

  GetAllUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add(new UserData.fromJson(v));
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

class UserData {
  String? sId;
  String? userName;
  String? email;
  String? profileImage;
  bool? send;

  UserData({this.sId, this.userName, this.email, this.profileImage, this.send});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userName = json['userName'];
    email = json['email'];
    profileImage = json['profile_image'];
    send = json['send'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['send'] = this.send;
    return data;
  }
}
