import 'problem_type.dart';
import 'ticket_priority.dart';
import 'ticket_status.dart';

class Ticket {
  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.problemType,
    required this.priority,
    required this.status,
    required this.createdByUserId,
    required this.createdByName,
    required this.createdAt,
    this.assignedToUserId,
    this.assignedToName,
    this.technicianNotes,
    this.updatedAt,
    this.markedAsPrank = false,
  });

  final String id;
  String title;
  String description;
  String location;
  ProblemType problemType;
  TicketPriority priority;
  TicketStatus status;
  final String createdByUserId;
  final String createdByName;
  final DateTime createdAt;
  String? assignedToUserId;
  String? assignedToName;
  String? technicianNotes;
  DateTime? updatedAt;
  bool markedAsPrank;

  Ticket copyWith({
    String? title,
    String? description,
    String? location,
    ProblemType? problemType,
    TicketPriority? priority,
    TicketStatus? status,
    String? assignedToUserId,
    String? assignedToName,
    String? technicianNotes,
    DateTime? updatedAt,
    bool? markedAsPrank,
  }) {
    return Ticket(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      problemType: problemType ?? this.problemType,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdByUserId: createdByUserId,
      createdByName: createdByName,
      createdAt: createdAt,
      assignedToUserId: assignedToUserId ?? this.assignedToUserId,
      assignedToName: assignedToName ?? this.assignedToName,
      technicianNotes: technicianNotes ?? this.technicianNotes,
      updatedAt: updatedAt ?? this.updatedAt,
      markedAsPrank: markedAsPrank ?? this.markedAsPrank,
    );
  }
}
