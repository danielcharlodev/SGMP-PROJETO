import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import 'mock_database.dart';

class AuthService extends ChangeNotifier {
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  /// Retorna mensagem de erro ou null se login OK.
  String? login(String email, String password) {
    final normalized = email.trim().toLowerCase();
    AppUser? user;
    for (final u in MockDatabase.users) {
      if (u.email.toLowerCase() == normalized && u.password == password) {
        user = u;
        break;
      }
    }

    if (user == null) {
      return 'E-mail ou senha incorretos.';
    }

    if (user.isBlocked) {
      return user.blockReason ??
          'Seu acesso foi bloqueado por uso indevido do sistema (ex.: chamados falsos). '
              'Procure a administração.';
    }

    _currentUser = user;
    notifyListeners();
    return null;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void refreshUser() {
    if (_currentUser == null) return;
    for (final u in MockDatabase.users) {
      if (u.id == _currentUser!.id) {
        _currentUser = u;
        notifyListeners();
        return;
      }
    }
  }
}
