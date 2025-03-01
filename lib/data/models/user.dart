import 'package:gemini_app/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  String userId;
  String email;
  String name;
  String profilePictureUrl;

  UserModel(
      {required this.userId,
      required this.email,
      required this.name,
      required this.profilePictureUrl});

  // Default empty user to avoid null cases
  static final empty = UserModel(
    userId: '',
    email: '',
    name: '',
    profilePictureUrl: '',
  );

  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      email: email,
      name: name,
      profilePictureUrl: profilePictureUrl,
    );
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      profilePictureUrl: entity.profilePictureUrl,
    );
  }

  // Factory constructor for creating a new instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  // Regular method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }
}
