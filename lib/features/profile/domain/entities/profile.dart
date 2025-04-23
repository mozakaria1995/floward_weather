import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String name;
  final String email;
  final String location;
  final String memberSince;
  final String avatarUrl;

  const Profile({
    required this.name,
    required this.email,
    required this.location,
    required this.memberSince,
    required this.avatarUrl,
  });

  @override
  List<Object> get props => [
        name,
        email,
        location,
        memberSince,
        avatarUrl,
      ];
}
