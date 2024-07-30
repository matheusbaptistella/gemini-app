// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UserModel',
      json,
      ($checkedConvert) {
        final val = UserModel(
          email: $checkedConvert('email', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          profilePictureUrl:
              $checkedConvert('profile_picture_url', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'profilePictureUrl': 'profile_picture_url'},
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'profile_picture_url': instance.profilePictureUrl,
    };
