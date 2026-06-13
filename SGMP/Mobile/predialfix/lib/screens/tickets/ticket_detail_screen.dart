import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/role_permissions.dart';
import '../../models/app_user.dart';
import '../../models/ticket_status.dart';
import '../../models/user_role.dart';
import '../../services/auth_service.dart';
import '../../services/ticket_service.dart';
import '../../services/user_service.dart';
import '../../widgets/status_chip.dart';
import '../../widgets/theme_toggle_button.dart';

class TicketDetailScreen extends StatefulWidget {
  const TicketDetailScreen({super.key, required this.ticketId});

  final String ticketId;

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  final _notesController = TextEditingController();
  String? _selectedEmployeeId;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<TicketService>();
    final ticket =
        context.read<TicketService>().getById(widget.ticketId);
    final user = context.read<AuthService>().currentUser!;

    if (ticket == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Chamado não encontrado')),
      );
    }

    if (_notesController.text.isEmpty && ticket.technicianNotes != null) {
      _notesController.text = ticket.technicianNotes!;
    }

    final dateFmt = DateFormat('dd/MM/yyyy HH:mm');
    final isAssigned = ticket.assignedToUserId == user.id;
    final canManage = RolePermissions.canManageTicketExecution(
      user.role,
      isAssigned: isAssigned,
    );
    final canAssign = RolePermissions.canAssignTickets(user.role) &&
        ticket.status != TicketStatus.concluido &&
        ticket.status != TicketStatus.cancelado;
    final isOwner = ticket.createdByUserId == user.id;
    final funcionarios = context.read<UserService>().listFuncionarios();

    if (_selectedEmployeeId == null && ticket.assignedToUserId != null) {
      _selectedEmployeeId = ticket.assignedToUserId;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Chamado #${ticket.id}'),
        actions: const [ThemeToggleButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            ticket.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          StatusChip(status: ticket.status),
          const SizedBox(height: 20),
          _InfoRow(
              icon: Icons.description_outlined,
              label: 'Descrição',
              value: ticket.description),
          _InfoRow(
              icon: Icons.place_outlined,
              label: 'Local',
              value: ticket.location),
          _InfoRow(
              icon: Icons.category_outlined,
              label: 'Tipo',
              value: ticket.problemType.label),
          _InfoRow(
              icon: Icons.flag_outlined,
              label: 'Prioridade',
              value: ticket.priority.label),
          _InfoRow(
              icon: Icons.person_outline,
              label: 'Aberto por',
              value: ticket.createdByName),
          _InfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Criado em',
              value: dateFmt.format(ticket.createdAt)),
          if (ticket.assignedToName != null)
            _InfoRow(
                icon: Icons.engineering_outlined,
                label: 'Funcionário',
                value: ticket.assignedToName!),
          if (ticket.updatedAt != null)
            _InfoRow(
                icon: Icons.update,
                label: 'Atualizado',
                value: dateFmt.format(ticket.updatedAt!)),
          if (ticket.technicianNotes != null &&
              ticket.technicianNotes!.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text('Observações do atendimento',
                style: TextStyle(fontWeight: FontWeight.w600)),
            Text(ticket.technicianNotes!),
          ],
          if (canAssign) ...[
            const Divider(height: 32),
            const Text('Atribuir chamado',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedEmployeeId,
              decoration: const InputDecoration(
                labelText: 'Funcionário responsável',
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('Selecione um funcionário'),
                ),
                ...funcionarios.map(
                  (f) => DropdownMenuItem(
                    value: f.id,
                    child: Text(f.name),
                  ),
                ),
              ],
              onChanged: (v) => setState(() => _selectedEmployeeId = v),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _selectedEmployeeId == null
                  ? null
                  : () => _assignTicket(context, funcionarios),
              icon: const Icon(Icons.person_add),
              label: const Text('Atribuir funcionário'),
            ),
          ],
          if (canManage &&
              ticket.status != TicketStatus.concluido &&
              ticket.status != TicketStatus.cancelado) ...[
            const Divider(height: 32),
            const Text('Atualizar atendimento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Observações / andamento',
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (ticket.status == TicketStatus.aberto)
                  ElevatedButton.icon(
                    onPressed: () => _setStatus(
                      context,
                      TicketStatus.emExecucao,
                    ),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Iniciar execução'),
                  ),
                if (ticket.status == TicketStatus.emExecucao)
                  ElevatedButton.icon(
                    onPressed: () => _setStatus(
                      context,
                      TicketStatus.concluido,
                    ),
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Finalizar'),
                  ),
                if (RolePermissions.canMarkPrank(user.role))
                  OutlinedButton.icon(
                    onPressed: () => _markPrank(context),
                    icon: const Icon(Icons.block, color: Colors.red),
                    label: const Text(
                      'Marcar como trote',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ],
          if (isOwner && user.role == UserRole.solicitante) ...[
            const SizedBox(height: 24),
            Card(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withValues(alpha: 0.35),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Acompanhe aqui o andamento do seu chamado. '
                  'O status será atualizado pelo funcionário responsável.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _assignTicket(BuildContext context, List<AppUser> funcionarios) {
    final employee = funcionarios.firstWhere(
      (f) => f.id == _selectedEmployeeId,
    );
    context.read<TicketService>().assignTicket(
          ticketId: widget.ticketId,
          employee: employee,
        );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Atribuído a ${employee.name}')),
    );
    setState(() {});
  }

  void _setStatus(BuildContext context, TicketStatus status) {
    final user = context.read<AuthService>().currentUser!;
    context.read<TicketService>().updateStatus(
          ticketId: widget.ticketId,
          status: status,
          technician: user,
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status: ${status.label}')),
    );
    setState(() {});
  }

  Future<void> _markPrank(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Marcar como trote?'),
        content: const Text(
          'Isso cancela o chamado. Após 2 trotes, o usuário será bloqueado '
          'automaticamente e não poderá abrir novos chamados.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Confirmar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirm != true || !context.mounted) return;

    final count =
        context.read<TicketService>().markAsPrank(widget.ticketId);
    context.read<AuthService>().refreshUser();

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          count >= 2
              ? 'Trote registrado. Usuário bloqueado por reincidência.'
              : 'Chamado marcado como trote.',
        ),
      ),
    );
    Navigator.pop(context);
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant)),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
