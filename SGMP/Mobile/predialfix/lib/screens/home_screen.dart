import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/role_permissions.dart';
import '../models/user_role.dart';
import '../services/auth_service.dart';
import '../widgets/senai_app_bar.dart';
import '../widgets/theme_toggle_button.dart';
import 'admin/admin_dashboard_screen.dart';
import 'admin/users_screen.dart';
import 'tickets/create_ticket_screen.dart';
import 'tickets/ticket_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  Future<void> _openCreateTicket() async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const CreateTicketScreen()),
    );
    if (created == true && mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthService>().currentUser!;
    final isAdmin = RolePermissions.showAdminDashboard(user.role);
    final canOpenTicket = RolePermissions.canOpenTicket(user.role);

    final pages = <Widget>[
      if (isAdmin)
        AdminDashboardScreen(
          onNavigateToTickets: () => setState(() => _index = 1),
        ),
      TicketListScreen(key: ValueKey('tickets-${user.id}')),
      if (isAdmin) const UsersScreen(),
    ];

    final destinations = <NavigationDestination>[
      if (isAdmin)
        const NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: 'Painel',
        ),
      const NavigationDestination(
        icon: Icon(Icons.assignment_outlined),
        selectedIcon: Icon(Icons.assignment),
        label: 'Chamados',
      ),
      if (isAdmin)
        const NavigationDestination(
          icon: Icon(Icons.people_outline),
          selectedIcon: Icon(Icons.people),
          label: 'Acessos',
        ),
    ];

    final showFab = canOpenTicket &&
        (user.role == UserRole.solicitante || (isAdmin && _index == 1));

    return Scaffold(
      appBar: SenaiAppBar(
        showLogo: false,
        title: isAdmin && _index == 0
            ? 'Painel Administrativo'
            : user.role.label,
        actions: [
          const ThemeToggleButton(),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () => context.read<AuthService>().logout(),
          ),
        ],
      ),
      body: IndexedStack(
        index: _index.clamp(0, pages.length - 1),
        children: pages,
      ),
      bottomNavigationBar: destinations.length > 1
          ? NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: (i) => setState(() => _index = i),
              destinations: destinations,
            )
          : null,
      floatingActionButton: showFab
          ? FloatingActionButton.extended(
              onPressed: _openCreateTicket,
              icon: const Icon(Icons.add),
              label: const Text('Novo chamado'),
            )
          : null,
    );
  }
}
