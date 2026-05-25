class LoginResponseModel {
  // 200
  String? token;
  String? userEmail;
  String? userNicename;
  String? userDisplayName;
  bool? success;

  // 403
  String? code;
  String? message;
  int? status;

  LoginResponseModel({
    this.token,
    this.userEmail,
    this.userNicename,
    this.userDisplayName,
    this.code,
    this.message,
    this.status,
    this.success
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json, int statusCode) {
    if (statusCode == 200) {
      success=true;
      token = json['token'];
      userEmail = json['user_email'];
      userNicename = json['user_nicename'];
      userDisplayName = json['user_display_name'];
    } else {
      success=false;
      code = json['code'];
      message = json['message'];
      status = json['data']?['status'];
    }
  }

  Map<String, dynamic> toJson() {
    if (token != null) {
      return {
        'token': token,
        'user_email': userEmail,
        'user_nicename': userNicename,
        'user_display_name': userDisplayName,
      };
    } else {
      return {
        'code': code,
        'message': message,
        'data': {'status': status},
      };
    }
  }

  bool get isSuccess => token != null;
}
