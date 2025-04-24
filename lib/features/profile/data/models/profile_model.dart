import 'package:floward_weather/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required String name,
    required String email,
    required String location,
    required String memberSince,
    required String avatarUrl,
    required String os,
  }) : super(
          name: name,
          email: email,
          location: location,
          memberSince: memberSince,
          avatarUrl: avatarUrl,
          os: os,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      email: json['email'],
      location: json['location'],
      memberSince: json['member_since'],
      avatarUrl: json['avatar_url'],
      os: json['os'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'location': location,
      'member_since': memberSince,
      'avatar_url': avatarUrl,
      'os': os,
    };
  }
}
