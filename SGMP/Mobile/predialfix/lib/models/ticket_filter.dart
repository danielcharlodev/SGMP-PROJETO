import 'problem_type.dart';
import 'ticket_priority.dart';
import 'ticket_status.dart';

/// Filtros enviados à camada de dados (simula requisição à API).
class TicketFilter {
  TicketFilter({
    this.statuses,
    this.problemType,
    this.location,
    this.createdByUserId,
    this.priority,
    this.searchQuery,
  });

  final Set<TicketStatus>? statuses;
  final ProblemType? problemType;
  final String? location;
  final String? createdByUserId;
  final TicketPriority? priority;
  final String? searchQuery;

  bool get isEmpty =>
      (statuses == null || statuses!.isEmpty) &&
      problemType == null &&
      (location == null || location!.isEmpty) &&
      createdByUserId == null &&
      priority == null &&
      (searchQuery == null || searchQuery!.trim().isEmpty);

  int get activeCount {
    var count = 0;
    if (statuses != null && statuses!.isNotEmpty) count++;
    if (problemType != null) count++;
    if (location != null && location!.isNotEmpty) count++;
    if (createdByUserId != null) count++;
    if (priority != null) count++;
    if (searchQuery != null && searchQuery!.trim().isNotEmpty) count++;
    return count;
  }

  TicketFilter copyWith({
    Set<TicketStatus>? statuses,
    ProblemType? problemType,
    String? location,
    String? createdByUserId,
    TicketPriority? priority,
    String? searchQuery,
    bool clearStatuses = false,
    bool clearProblemType = false,
    bool clearLocation = false,
    bool clearCreatedBy = false,
    bool clearPriority = false,
    bool clearSearch = false,
  }) {
    return TicketFilter(
      statuses: clearStatuses ? null : (statuses ?? this.statuses),
      problemType:
          clearProblemType ? null : (problemType ?? this.problemType),
      location: clearLocation ? null : (location ?? this.location),
      createdByUserId:
          clearCreatedBy ? null : (createdByUserId ?? this.createdByUserId),
      priority: clearPriority ? null : (priority ?? this.priority),
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
    );
  }

  static TicketFilter forTechnicianPending() => TicketFilter(
        statuses: {TicketStatus.aberto, TicketStatus.emExecucao},
      );

  static TicketFilter forUserTickets(String userId) =>
      TicketFilter(createdByUserId: userId);

  static TicketFilter forLocation(String location) =>
      TicketFilter(location: location);
}
