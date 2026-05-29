import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../models/problem_type.dart';
import '../models/ticket.dart';
import '../models/ticket_filter.dart';
import '../models/ticket_priority.dart';
import '../models/ticket_status.dart';
import 'mock_database.dart';

class TicketService extends ChangeNotifier {
  /// Simula GET /chamados?filtros=...
  List<Ticket> fetchTickets(TicketFilter filter) {
    var result = List<Ticket>.from(MockDatabase.tickets);

    if (filter.statuses != null && filter.statuses!.isNotEmpty) {
      result =
          result.where((t) => filter.statuses!.contains(t.status)).toList();
    }
    if (filter.problemType != null) {
      result =
          result.where((t) => t.problemType == filter.problemType).toList();
    }
    if (filter.location != null && filter.location!.isNotEmpty) {
      result = result
          .where((t) =>
              t.location.toLowerCase() ==
              filter.location!.trim().toLowerCase())
          .toList();
    }
    if (filter.createdByUserId != null) {
      result = result
          .where((t) => t.createdByUserId == filter.createdByUserId)
          .toList();
    }
    if (filter.priority != null) {
      result = result.where((t) => t.priority == filter.priority).toList();
    }
    if (filter.searchQuery != null && filter.searchQuery!.trim().isNotEmpty) {
      final q = filter.searchQuery!.trim().toLowerCase();
      result = result
          .where((t) =>
              t.title.toLowerCase().contains(q) ||
              t.description.toLowerCase().contains(q) ||
              t.location.toLowerCase().contains(q))
          .toList();
    }

    result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return result;
  }

  Ticket? getById(String id) {
    try {
      return MockDatabase.tickets.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  Ticket createTicket({
    required AppUser author,
    required String title,
    required String description,
    required String location,
    required ProblemType problemType,
    TicketPriority priority = TicketPriority.media,
  }) {
    if (author.isBlocked) {
      throw StateError('Usuário bloqueado não pode abrir chamados.');
    }

    final ticket = Ticket(
      id: MockDatabase.nextTicketId(),
      title: title.trim(),
      description: description.trim(),
      location: location,
      problemType: problemType,
      priority: priority,
      status: TicketStatus.aberto,
      createdByUserId: author.id,
      createdByName: author.name,
      createdAt: DateTime.now(),
    );
    MockDatabase.tickets.insert(0, ticket);
    notifyListeners();
    return ticket;
  }

  void updateTicket(Ticket updated) {
    final index = MockDatabase.tickets.indexWhere((t) => t.id == updated.id);
    if (index >= 0) {
      MockDatabase.tickets[index] = updated;
      notifyListeners();
    }
  }

  void updateStatus({
    required String ticketId,
    required TicketStatus status,
    AppUser? technician,
    String? notes,
  }) {
    final ticket = getById(ticketId);
    if (ticket == null) return;

    final updated = ticket.copyWith(
      status: status,
      assignedToUserId: technician?.id ?? ticket.assignedToUserId,
      assignedToName: technician?.name ?? ticket.assignedToName,
      technicianNotes: notes ?? ticket.technicianNotes,
      updatedAt: DateTime.now(),
    );
    updateTicket(updated);
  }

  /// Marca chamado como trote e incrementa penalidade do autor.
  int markAsPrank(String ticketId) {
    final ticket = getById(ticketId);
    if (ticket == null) return 0;

    ticket.markedAsPrank = true;
    ticket.status = TicketStatus.cancelado;
    ticket.updatedAt = DateTime.now();
    notifyListeners();

    final prankCount = MockDatabase.tickets
        .where((t) =>
            t.createdByUserId == ticket.createdByUserId && t.markedAsPrank)
        .length;

    if (prankCount >= 2) {
      final userIndex = MockDatabase.users
          .indexWhere((u) => u.id == ticket.createdByUserId);
      if (userIndex >= 0) {
        MockDatabase.users[userIndex] = MockDatabase.users[userIndex].copyWith(
          isBlocked: true,
          blockReason:
              'Bloqueado após $prankCount chamados identificados como trote.',
        );
      }
    }
    return prankCount;
  }
}
