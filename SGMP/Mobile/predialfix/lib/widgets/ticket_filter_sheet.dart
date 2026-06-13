import 'package:flutter/material.dart';

import '../core/constants.dart';
import '../models/app_user.dart';
import '../models/problem_type.dart';
import '../models/ticket_filter.dart';
import '../models/ticket_priority.dart';
import '../models/ticket_status.dart';
import '../models/user_role.dart';

class TicketFilterSheet extends StatefulWidget {
  const TicketFilterSheet({
    super.key,
    required this.initialFilter,
    required this.onApply,
    this.allowAuthorFilter = true,
    this.usersForFilter,
  });

  final TicketFilter initialFilter;
  final ValueChanged<TicketFilter> onApply;
  final bool allowAuthorFilter;
  final List<AppUser>? usersForFilter;

  @override
  State<TicketFilterSheet> createState() => _TicketFilterSheetState();
}

class _TicketFilterSheetState extends State<TicketFilterSheet> {
  late Set<TicketStatus> _statuses;
  ProblemType? _problemType;
  String? _location;
  String? _authorId;
  TicketPriority? _priority;

  @override
  void initState() {
    super.initState();
    _statuses = Set.from(widget.initialFilter.statuses ?? {});
    _problemType = widget.initialFilter.problemType;
    _location = widget.initialFilter.location;
    _authorId = widget.initialFilter.createdByUserId;
    _priority = widget.initialFilter.priority;
  }

  TicketFilter _buildFilter() => TicketFilter(
        statuses: _statuses.isEmpty ? null : _statuses,
        problemType: _problemType,
        location: _location,
        createdByUserId: _authorId,
        priority: _priority,
      );

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filtrar chamados',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _statuses.clear();
                        _problemType = null;
                        _location = null;
                        _authorId = null;
                        _priority = null;
                      });
                    },
                    child: const Text('Limpar'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Status', style: TextStyle(fontWeight: FontWeight.w600)),
              Wrap(
                spacing: 8,
                children: TicketStatus.values.map((s) {
                  final selected = _statuses.contains(s);
                  return FilterChip(
                    label: Text(s.label),
                    selected: selected,
                    onSelected: (v) {
                      setState(() {
                        if (v) {
                          _statuses.add(s);
                        } else {
                          _statuses.remove(s);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text('Tipo de problema',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              DropdownButtonFormField<ProblemType?>(
                value: _problemType,
                decoration: const InputDecoration(labelText: 'Tipo'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('Todos')),
                  ...ProblemType.values.map(
                    (t) => DropdownMenuItem(value: t, child: Text(t.label)),
                  ),
                ],
                onChanged: (v) => setState(() => _problemType = v),
              ),
              const SizedBox(height: 12),
              const Text('Local', style: TextStyle(fontWeight: FontWeight.w600)),
              DropdownButtonFormField<String?>(
                value: _location,
                decoration: const InputDecoration(labelText: 'Local'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('Todos')),
                  ...AppConstants.locations.map(
                    (l) => DropdownMenuItem(value: l, child: Text(l)),
                  ),
                ],
                onChanged: (v) => setState(() => _location = v),
              ),
              const SizedBox(height: 12),
              const Text('Prioridade',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              DropdownButtonFormField<TicketPriority?>(
                value: _priority,
                decoration: const InputDecoration(labelText: 'Prioridade'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('Todas')),
                  ...TicketPriority.values.map(
                    (p) => DropdownMenuItem(value: p, child: Text(p.label)),
                  ),
                ],
                onChanged: (v) => setState(() => _priority = v),
              ),
              if (widget.allowAuthorFilter &&
                  widget.usersForFilter != null) ...[
                const SizedBox(height: 12),
                const Text('Aberto por',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                DropdownButtonFormField<String?>(
                  value: _authorId,
                  decoration:
                      const InputDecoration(labelText: 'Usuário'),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Todos')),
                    ...widget.usersForFilter!
                        .where((u) => u.role == UserRole.solicitante)
                        .map(
                      (u) => DropdownMenuItem(
                        value: u.id,
                        child: Text(u.name),
                      ),
                    ),
                  ],
                  onChanged: (v) => setState(() => _authorId = v),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(_buildFilter());
                    Navigator.pop(context);
                  },
                  child: const Text('Aplicar filtros'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
