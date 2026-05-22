class LoginResponseModel {
  String? token;
  String? userEmail;
  String? userDisplayName;
  String? message;
  String? code;

  LoginResponseModel({
    this.token,
    this.message,
    this.userEmail,
    this.userDisplayName,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json["token"] ?? "";
    message = json["message"] ?? "";
    code = json["code"] ?? "";
    userEmail = json["user_email"] ?? "";
    userDisplayName = json["user_display_name"] ?? "";
  }
}
