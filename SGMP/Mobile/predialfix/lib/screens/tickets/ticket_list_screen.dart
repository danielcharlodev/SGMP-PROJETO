import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/ticket.dart';
import '../../models/ticket_filter.dart';
import '../../models/ticket_status.dart';
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
  late TicketFilter _filter;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filter = _defaultFilterForRole();
  }

  TicketFilter _defaultFilterForRole() {
    final user = context.read<AuthService>().currentUser!;
    switch (user.role) {
      case UserRole.comum:
        return TicketFilter.forUserTickets(user.id);
      case UserRole.tecnico:
        return TicketFilter.forTechnicianPending();
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
    final users = user.role != UserRole.comum
        ? context.read<UserService>().listUsers()
        : null;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => TicketFilterSheet(
        initialFilter: _filter,
        allowAuthorFilter: user.role != UserRole.comum,
        usersForFilter: users,
        onApply: (f) => setState(() => _filter = f),
      ),
    );
  }

  TicketFilter _effectiveFilter() {
    final user = context.read<AuthService>().currentUser!;
    var f = _filter;
    if (user.role == UserRole.comum) {
      f = f.copyWith(createdByUserId: user.id);
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

  @override
  Widget build(BuildContext context) {
    context.watch<TicketService>();
    final user = context.watch<AuthService>().currentUser!;
    final tickets = _loadTickets();
    final showAuthor =
        user.role == UserRole.tecnico || user.role == UserRole.administrador;

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
              Badge(
                isLabelVisible: _filter.activeCount > 0,
                label: Text('${_filter.activeCount}'),
                child: IconButton(
                  icon: const Icon(Icons.filter_list),
                  tooltip: 'Filtros',
                  onPressed: _openFilters,
                ),
              ),
            ],
          ),
        ),
        if (user.role == UserRole.comum)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'Exibindo apenas seus chamados',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          ),
        if (user.role == UserRole.tecnico &&
            _filter.statuses?.contains(TicketStatus.aberto) == true)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              'Filtro padrão: Em aberto e Em execução',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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
                      if (_filter.activeCount > 0)
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
