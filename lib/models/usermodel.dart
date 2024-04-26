class UserModel {
  String? userId;
  String? userName;
  String? fullName;
  String? userTypeId;
  String? pictureName;
  String? userTypeName;

  UserModel(
      {this.userId,
      this.userName,
      this.fullName,
      this.userTypeId,
      this.pictureName,
      this.userTypeName});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    fullName = json['full_name'];
    userTypeId = json['user_type_id'];
    pictureName = json['picture_name'];
    userTypeName = json['user_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['full_name'] = fullName;
    data['user_type_id'] = userTypeId;
    data['picture_name'] = pictureName;
    data['user_type_name'] = userTypeName;
    return data;
  }
}
