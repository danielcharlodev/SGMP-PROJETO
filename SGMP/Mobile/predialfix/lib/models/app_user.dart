import 'user_role.dart';

class AppUser {
  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.isBlocked = false,
    this.blockReason,
  });

  final String id;
  final String name;
  final String email;
  final String password;
  UserRole role;
  bool isBlocked;
  String? blockReason;

  AppUser copyWith({
    String? name,
    UserRole? role,
    bool? isBlocked,
    String? blockReason,
    bool clearBlockReason = false,
  }) {
    return AppUser(
      id: id,
      name: name ?? this.name,
      email: email,
      password: password,
      role: role ?? this.role,
      isBlocked: isBlocked ?? this.isBlocked,
      blockReason: clearBlockReason ? null : (blockReason ?? this.blockReason),
    );
  }
}
