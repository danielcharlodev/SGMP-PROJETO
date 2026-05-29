import 'package:flutter/material.dart';

import '../models/ticket_priority.dart';
import '../models/ticket_status.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final TicketStatus status;

  Color get _color {
    switch (status) {
      case TicketStatus.aberto:
        return Colors.orange;
      case TicketStatus.emExecucao:
        return Colors.blue;
      case TicketStatus.concluido:
        return Colors.green;
      case TicketStatus.cancelado:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: _color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class PriorityChip extends StatelessWidget {
  const PriorityChip({super.key, required this.priority});

  final TicketPriority priority;

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (priority) {
      case TicketPriority.baixa:
        color = Colors.teal;
      case TicketPriority.media:
        color = Colors.blue;
      case TicketPriority.alta:
        color = Colors.orange;
      case TicketPriority.urgente:
        color = Colors.red;
    }
    return Text(
      priority.label,
      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
    );
  }
}
