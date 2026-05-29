import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../models/user_role.dart';
import 'mock_database.dart';

class UserService extends ChangeNotifier {
  List<AppUser> listUsers() =>
      List<AppUser>.from(MockDatabase.users)
        ..sort((a, b) => a.name.compareTo(b.name));

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

  AppUser createUser({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) {
    final user = AppUser(
      id: MockDatabase.nextUserId(),
      name: name.trim(),
      email: email.trim().toLowerCase(),
      password: password,
      role: role,
    );
    MockDatabase.users.add(user);
    notifyListeners();
    return user;
  }
}
