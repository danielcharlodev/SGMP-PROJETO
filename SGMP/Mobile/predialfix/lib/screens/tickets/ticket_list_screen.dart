import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/role_permissions.dart';
import '../../models/ticket.dart';
import '../../models/ticket_filter.dart';
import '../../models/user_role.dart';
import '../../services/auth_service.dart';
import '../../services/ticket_service.dart';
import '../../services/user_service.dart';
import '../../widgets/ticket_card.dart';
import '../../widgets/ticket_filter_sheet.dart';
import 'ticket_detail_screen.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  TicketFilter? _filter;
  final _searchController = TextEditingController();
  bool _filterReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_filterReady) {
      _filter = _defaultFilterForRole();
      _filterReady = true;
    }
  }

  TicketFilter _defaultFilterForRole() {
    final user = context.read<AuthService>().currentUser!;
    switch (user.role) {
      case UserRole.solicitante:
        return TicketFilter.forUserTickets(user.id);
      case UserRole.funcionario:
        return TicketFilter.forAssignedTickets(user.id);
      case UserRole.gerente:
        return TicketFilter.forGerentePending();
      case UserRole.administrador:
        return TicketFilter();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openFilters() {
    final user = context.read<AuthService>().currentUser!;
    final users = RolePermissions.canUseAdvancedFilters(user.role)
        ? context.read<UserService>().listUsers()
        : null;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => TicketFilterSheet(
        initialFilter: _filter!,
        allowAuthorFilter: RolePermissions.canUseAdvancedFilters(user.role),
        usersForFilter: users,
        onApply: (f) => setState(() => _filter = f),
      ),
    );
  }

  TicketFilter _effectiveFilter() {
    final user = context.read<AuthService>().currentUser!;
    var f = _filter ?? _defaultFilterForRole();

    switch (user.role) {
      case UserRole.solicitante:
        f = f.copyWith(createdByUserId: user.id);
      case UserRole.funcionario:
        f = f.copyWith(assignedToUserId: user.id);
      case UserRole.gerente:
      case UserRole.administrador:
        break;
    }

    final q = _searchController.text.trim();
    return f.copyWith(
      searchQuery: q.isEmpty ? null : q,
      clearSearch: q.isEmpty,
    );
  }

  List<Ticket> _loadTickets() {
    return context.read<TicketService>().fetchTickets(_effectiveFilter());
  }

  String? _roleHint(UserRole role) {
    switch (role) {
      case UserRole.solicitante:
        return 'Exibindo apenas seus chamados';
      case UserRole.funcionario:
        return 'Exibindo chamados atribuídos a você';
      case UserRole.gerente:
        return 'Atribua chamados abertos aos funcionários';
      case UserRole.administrador:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<TicketService>();
    final user = context.watch<AuthService>().currentUser!;
    if (_filter == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final tickets = _loadTickets();
    final showAuthor = RolePermissions.canSeeAllTickets(user.role);
    final hint = _roleHint(user.role);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Olá, ${user.name.split(' ').first}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (RolePermissions.canUseAdvancedFilters(user.role))
                Badge(
                  isLabelVisible: _filter!.activeCount > 0,
                  label: Text('${_filter!.activeCount}'),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list),
                    tooltip: 'Filtros',
                    onPressed: _openFilters,
                  ),
                ),
            ],
          ),
        ),
        if (hint != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                hint,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar chamados...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  setState(() {});
                },
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        Expanded(
          child: tickets.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.inbox_outlined,
                          size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      const Text('Nenhum chamado encontrado'),
                      if (_filter!.activeCount > 0)
                        TextButton(
                          onPressed: () =>
                              setState(() => _filter = _defaultFilterForRole()),
                          child: const Text('Restaurar filtro padrão'),
                        ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async => setState(() {}),
                  child: ListView.builder(
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];
                      return TicketCard(
                        ticket: ticket,
                        showAuthor: showAuthor,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  TicketDetailScreen(ticketId: ticket.id),
                            ),
                          );
                          if (mounted) setState(() {});
                        },
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
