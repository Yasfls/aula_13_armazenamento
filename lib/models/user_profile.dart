import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  int score;

  UserProfile({
    required this.name,
    required this.email,
    required this.createdAt,
    required this.score,
  });
}