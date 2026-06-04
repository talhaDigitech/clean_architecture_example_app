// To parse this JSON data, do
//
//     final loginDto = loginDtoFromJson(jsonString);

import 'dart:convert';

LoginDto loginDtoFromJson(String str) => LoginDto.fromJson(json.decode(str));

String loginDtoToJson(LoginDto data) => json.encode(data.toJson());

class LoginDto {
    int? statusCode;
    Data? data;
    String? message;
    bool? success;

    LoginDto({
        this.statusCode,
        this.data,
        this.message,
        this.success,
    });

    factory LoginDto.fromJson(Map<String, dynamic> json) => LoginDto(
        statusCode: json["statusCode"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data?.toJson(),
        "message": message,
        "success": success,
    };
}

class Data {
    User? user;
    String? token;

    Data({
        this.user,
        this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
    };
}

class User {
    int? id;
    String? status;
    DateTime? updatedAt;
    String? name;
    String? email;
    String? phone;
    String? deviceInfo;
    String? deviceId;
    String? fcmToken;
    bool? eulaAgreed;
    DateTime? eulaAgreedAt;

    User({
        this.id,
        this.status,
        this.updatedAt,
        this.name,
        this.email,
        this.phone,
        this.deviceInfo,
        this.deviceId,
        this.fcmToken,
        this.eulaAgreed,
        this.eulaAgreedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        status: json["status"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        deviceInfo: json["deviceInfo"],
        deviceId: json["deviceId"],
        fcmToken: json["fcmToken"],
        eulaAgreed: json["eulaAgreed"],
        eulaAgreedAt: json["eulaAgreedAt"] == null ? null : DateTime.parse(json["eulaAgreedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "updatedAt": updatedAt?.toIso8601String(),
        "name": name,
        "email": email,
        "phone": phone,
        "deviceInfo": deviceInfo,
        "deviceId": deviceId,
        "fcmToken": fcmToken,
        "eulaAgreed": eulaAgreed,
        "eulaAgreedAt": eulaAgreedAt?.toIso8601String(),
    };
}
