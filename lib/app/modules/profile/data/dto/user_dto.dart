import 'package:clean_architecture_example_app/app/modules/profile/domain/entities/user_entity.dart';

class UserDto {
  final String userName;
  final String email;
  final String phone;

  const UserDto({
    required this.userName,
    required this.email,
    required this.phone,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      userName: json['userName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      userName: userName,
      email: email,
      phone: phone,
    );
  }
}
