import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../models/user_role.dart';
import 'mock_database.dart';

class UserService extends ChangeNotifier {
  List<AppUser> listUsers() =>
      List<AppUser>.from(MockDatabase.users)
        ..sort((a, b) => a.name.compareTo(b.name));

  List<AppUser> searchUsers({
    String? query,
    UserRole? roleFilter,
  }) {
    var users = listUsers();
    final q = query?.trim().toLowerCase() ?? '';

    if (q.isNotEmpty) {
      final digits = q.replaceAll(RegExp(r'\D'), '');
      users = users.where((u) {
        final matchesText = u.name.toLowerCase().contains(q) ||
            u.email.toLowerCase().contains(q) ||
            u.role.label.toLowerCase().contains(q);
        final matchesCpf = digits.isNotEmpty &&
            u.cpf.replaceAll(RegExp(r'\D'), '').contains(digits);
        return matchesText || matchesCpf;
      }).toList();
    }

    if (roleFilter != null) {
      users = users.where((u) => u.role == roleFilter).toList();
    }

    return users;
  }

  List<AppUser> listFuncionarios() =>
      listUsers().where((u) => u.role == UserRole.funcionario).toList();

  AppUser? getById(String id) {
    try {
      return MockDatabase.users.firstWhere((u) => u.id == id);
    } catch (_) {
      return null;
    }
  }

  void updateRole(String userId, UserRole role) {
    final index = MockDatabase.users.indexWhere((u) => u.id == userId);
    if (index < 0) return;
    MockDatabase.users[index] =
        MockDatabase.users[index].copyWith(role: role);
    notifyListeners();
  }

  void updateUser({
    required String userId,
    required String name,
    required String email,
    required String cpf,
    required UserRole role,
  }) {
    final index = MockDatabase.users.indexWhere((u) => u.id == userId);
    if (index < 0) return;
    MockDatabase.users[index] = MockDatabase.users[index].copyWith(
      name: name.trim(),
      email: email.trim().toLowerCase(),
      cpf: cpf.replaceAll(RegExp(r'\D'), ''),
      role: role,
    );
    notifyListeners();
  }

  void setBlocked(String userId, bool blocked, {String? reason}) {
    final index = MockDatabase.users.indexWhere((u) => u.id == userId);
    if (index < 0) return;
    MockDatabase.users[index] = MockDatabase.users[index].copyWith(
      isBlocked: blocked,
      blockReason: blocked ? (reason ?? 'Bloqueado pela administração.') : null,
      clearBlockReason: !blocked,
    );
    notifyListeners();
  }

  bool deleteUser(String userId) {
    final index = MockDatabase.users.indexWhere((u) => u.id == userId);
    if (index < 0) return false;
    MockDatabase.users.removeAt(index);
    notifyListeners();
    return true;
  }

  AppUser createUser({
    required String name,
    required String email,
    required String cpf,
    required String password,
    required UserRole role,
  }) {
    final user = AppUser(
      id: MockDatabase.nextUserId(),
      name: name.trim(),
      email: email.trim().toLowerCase(),
      cpf: cpf.replaceAll(RegExp(r'\D'), ''),
      password: password,
      role: role,
    );
    MockDatabase.users.add(user);
    notifyListeners();
    return user;
  }

  int countUsers() => MockDatabase.users.length;

  int countActiveFuncionarios() => MockDatabase.users
      .where((u) => u.role == UserRole.funcionario && !u.isBlocked)
      .length;
}
