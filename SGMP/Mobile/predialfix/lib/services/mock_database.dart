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
      email: 'solicitante@senai.com',
      cpf: '12345678901',
      password: '123456',
      role: UserRole.solicitante,
    ),
    AppUser(
      id: 'u2',
      name: 'João Santos',
      email: 'funcionario@senai.com',
      cpf: '98765432100',
      password: '123456',
      role: UserRole.funcionario,
    ),
    AppUser(
      id: 'u3',
      name: 'Pedro Gerente',
      email: 'gerente@senai.com',
      cpf: '11122233344',
      password: '123456',
      role: UserRole.gerente,
    ),
    AppUser(
      id: 'u4',
      name: 'Ana Administradora',
      email: 'admin@senai.com',
      cpf: '55566677788',
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
      problemType: ProblemType.infraestrutura,
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
      problemType: ProblemType.infraestrutura,
      priority: TicketPriority.media,
      status: TicketStatus.emExecucao,
      createdByUserId: 'u1',
      createdByName: 'Maria Silva',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      assignedToUserId: 'u2',
      assignedToName: 'João Santos',
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
      assignedToUserId: 'u2',
      assignedToName: 'João Santos',
      technicianNotes: 'Lâmpadas substituídas.',
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  static int _ticketCounter = 4;
  static int _userCounter = 5;

  static String nextTicketId() => 't${_ticketCounter++}';
  static String nextUserId() => 'u${_userCounter++}';
}
