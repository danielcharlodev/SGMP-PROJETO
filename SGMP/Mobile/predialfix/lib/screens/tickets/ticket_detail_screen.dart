import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/ticket_status.dart';
import '../../models/user_role.dart';
import '../../services/auth_service.dart';
import '../../services/ticket_service.dart';
import '../../widgets/status_chip.dart';

class TicketDetailScreen extends StatefulWidget {
  const TicketDetailScreen({super.key, required this.ticketId});

  final String ticketId;

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  final _notesController = TextEditingController();

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
    final canManage = user.role == UserRole.tecnico ||
        user.role == UserRole.administrador;
    final isOwner = ticket.createdByUserId == user.id;

    return Scaffold(
      appBar: AppBar(title: Text('Chamado #${ticket.id}')),
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
          _InfoRow(icon: Icons.description_outlined, label: 'Descrição', value: ticket.description),
          _InfoRow(icon: Icons.place_outlined, label: 'Local', value: ticket.location),
          _InfoRow(icon: Icons.category_outlined, label: 'Tipo', value: ticket.problemType.label),
          _InfoRow(icon: Icons.flag_outlined, label: 'Prioridade', value: ticket.priority.label),
          _InfoRow(icon: Icons.person_outline, label: 'Aberto por', value: ticket.createdByName),
          _InfoRow(icon: Icons.calendar_today_outlined, label: 'Criado em', value: dateFmt.format(ticket.createdAt)),
          if (ticket.assignedToName != null)
            _InfoRow(icon: Icons.engineering_outlined, label: 'Técnico', value: ticket.assignedToName!),
          if (ticket.updatedAt != null)
            _InfoRow(icon: Icons.update, label: 'Atualizado', value: dateFmt.format(ticket.updatedAt!)),
          if (ticket.technicianNotes != null && ticket.technicianNotes!.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text('Observações do técnico',
                style: TextStyle(fontWeight: FontWeight.w600)),
            Text(ticket.technicianNotes!),
          ],
          if (canManage && ticket.status != TicketStatus.concluido &&
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
                if (user.role == UserRole.administrador)
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
          if (isOwner && user.role == UserRole.comum) ...[
            const SizedBox(height: 24),
            Card(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Acompanhe aqui o andamento do seu chamado. '
                  'O status será atualizado pelo responsável técnico.',
                ),
              ),
            ),
          ],
        ],
      ),
    );
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
                        fontSize: 12, color: Colors.grey.shade700)),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
