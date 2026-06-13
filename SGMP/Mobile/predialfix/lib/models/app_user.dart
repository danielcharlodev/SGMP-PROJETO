import 'user_role.dart';

class AppUser {
  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.cpf,
    required this.password,
    required this.role,
    this.isBlocked = false,
    this.blockReason,
  });

  final String id;
  final String name;
  final String email;
  final String cpf;
  final String password;
  UserRole role;
  bool isBlocked;
  String? blockReason;

  String get formattedCpf {
    final digits = cpf.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 11) return cpf;
    return '${digits.substring(0, 3)}.${digits.substring(3, 6)}.'
        '${digits.substring(6, 9)}-${digits.substring(9)}';
  }

  AppUser copyWith({
    String? name,
    String? email,
    String? cpf,
    UserRole? role,
    bool? isBlocked,
    String? blockReason,
    bool clearBlockReason = false,
  }) {
    return AppUser(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      password: password,
      role: role ?? this.role,
      isBlocked: isBlocked ?? this.isBlocked,
      blockReason: clearBlockReason ? null : (blockReason ?? this.blockReason),
    );
  }
}
