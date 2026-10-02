// To parse this JSON data, do
//
//     final loginDto = loginDtoFromJson(jsonString);

import 'dart:convert';

LoginDto loginDtoFromJson(String str) => LoginDto.fromJson(json.decode(str));

String loginDtoToJson(LoginDto data) => json.encode(data.toJson());

class LoginDto {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String scope;

  LoginDto({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.scope,
  });

  factory LoginDto.fromJson(Map<String, dynamic> json) => LoginDto(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    scope: json["scope"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "scope": scope,
  };
}
