import '../models/user_role.dart';

class RolePermissions {
  static bool canManageUsers(UserRole role) =>
      role == UserRole.administrador;

  static bool canOpenTicket(UserRole role) =>
      role == UserRole.solicitante || role == UserRole.administrador;

  static bool canAssignTickets(UserRole role) => role == UserRole.gerente;

  static bool canManageTicketExecution(UserRole role, {required bool isAssigned}) {
    if (role == UserRole.administrador) return true;
    if (role == UserRole.funcionario) return isAssigned;
    return false;
  }

  static bool canSeeAllTickets(UserRole role) =>
      role == UserRole.administrador || role == UserRole.gerente;

  static bool canMarkPrank(UserRole role) => role == UserRole.administrador;

  static bool showAdminDashboard(UserRole role) =>
      role == UserRole.administrador;

  static bool canUseAdvancedFilters(UserRole role) =>
      role == UserRole.administrador || role == UserRole.gerente;
}
