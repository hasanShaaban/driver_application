class LoginModel {
  final String status;
  final String message;
  final LoginData data;

  const LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] as String,
      message: json['message'] as String,
      data: LoginData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class LoginData {
  final int id;
  final String? username;
  final String role;
  final String accessToken;
  final String tokenType;

  const LoginData({
    required this.id,
    this.username,
    required this.role,
    required this.accessToken,
    required this.tokenType,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['id'] as int,
      username: json['username'] as String?,
      role: json['role'] as String,
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'role': role,
      'access_token': accessToken,
      'token_type': tokenType,
    };
  }
}
