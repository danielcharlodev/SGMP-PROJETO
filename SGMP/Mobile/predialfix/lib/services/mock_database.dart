import '../models/app_user.dart';
import '../models/problem_type.dart';
import '../models/ticket.dart';
import '../models/ticket_priority.dart';
import '../models/ticket_status.dart';
import '../models/user_role.dart';

/// Dados em memória — substituir por chamadas HTTP à API real.
class MockDatabase {
  static final List<AppUser> users = [
    AppUser(
      id: 'u1',
      name: 'Maria Silva',
      email: 'aluno@senai.com',
      password: '123456',
      role: UserRole.comum,
    ),
    AppUser(
      id: 'u2',
      name: 'João Santos',
      email: 'funcionario@senai.com',
      password: '123456',
      role: UserRole.comum,
    ),
    AppUser(
      id: 'u3',
      name: 'Carlos Técnico',
      email: 'tecnico@senai.com',
      password: '123456',
      role: UserRole.tecnico,
    ),
    AppUser(
      id: 'u4',
      name: 'Ana Administradora',
      email: 'admin@senai.com',
      password: '123456',
      role: UserRole.administrador,
    ),
  ];

  static final List<Ticket> tickets = [
    Ticket(
      id: 't1',
      title: 'Ar-condicionado sem funcionar',
      description:
          'O ar-condicionado da sala 204 não liga. Está muito quente para as aulas.',
      location: 'Bloco A',
      problemType: ProblemType.arCondicionado,
      priority: TicketPriority.alta,
      status: TicketStatus.aberto,
      createdByUserId: 'u1',
      createdByName: 'Maria Silva',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Ticket(
      id: 't2',
      title: 'Vazamento no banheiro',
      description: 'Torneira pingando constantemente no banheiro masculino.',
      location: 'Bloco B',
      problemType: ProblemType.hidraulica,
      priority: TicketPriority.media,
      status: TicketStatus.emExecucao,
      createdByUserId: 'u2',
      createdByName: 'João Santos',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      assignedToUserId: 'u3',
      assignedToName: 'Carlos Técnico',
      updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Ticket(
      id: 't3',
      title: 'Lâmpada queimada',
      description: 'Três lâmpadas do corredor estão apagadas.',
      location: 'Bloco A',
      problemType: ProblemType.eletrica,
      priority: TicketPriority.baixa,
      status: TicketStatus.concluido,
      createdByUserId: 'u1',
      createdByName: 'Maria Silva',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      assignedToUserId: 'u3',
      assignedToName: 'Carlos Técnico',
      technicianNotes: 'Lâmpadas substituídas.',
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  static int _ticketCounter = 4;
  static int _userCounter = 5;

  static String nextTicketId() => 't${_ticketCounter++}';
  static String nextUserId() => 'u${_userCounter++}';
}
