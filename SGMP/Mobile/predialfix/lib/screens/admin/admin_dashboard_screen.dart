import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_theme.dart';
import '../../models/dashboard_stats.dart';
import '../../models/problem_type.dart';
import '../../models/ticket.dart';
import '../../services/auth_service.dart';
import '../../services/ticket_service.dart';
import '../../services/user_service.dart';
import '../tickets/create_ticket_screen.dart';
import '../tickets/ticket_detail_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({
    super.key,
    this.onNavigateToTickets,
  });

  final VoidCallback? onNavigateToTickets;

  @override
  Widget build(BuildContext context) {
    context.watch<TicketService>();
    context.watch<UserService>();

    final theme = Theme.of(context);
    final user = context.read<AuthService>().currentUser!;
    final userService = context.read<UserService>();
    final ticketService = context.read<TicketService>();
    final stats = ticketService.getDashboardStats(
      usuariosCadastrados: userService.countUsers(),
      funcionariosAtivos: userService.countActiveFuncionarios(),
    );
    final recent = ticketService.recentTickets(limit: 5);

    return RefreshIndicator(
      color: AppTheme.senaiRed,
      onRefresh: () async {},
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá, ${user.name.split(' ').first} 👋',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.role.label,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Visão geral dos chamados',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Acompanhe indicadores e chamados recentes.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await Navigator.push<bool>(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CreateTicketScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('Novo chamado'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _StatsGrid(stats: stats),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  _RecentTicketsSection(
                    tickets: recent,
                    onViewAll: onNavigateToTickets,
                  ),
                  const SizedBox(height: 16),
                  _CategorySection(stats: stats),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.stats});

  final DashboardStats stats;

  @override
  Widget build(BuildContext context) {
    final items = [
      _StatItem('Total de chamados', stats.totalChamados, Icons.assignment,
          Colors.blue),
      _StatItem('Pendentes', stats.pendentes, Icons.schedule, Colors.orange),
      _StatItem('Em andamento', stats.emAndamento, Icons.sync, Colors.purple),
      _StatItem('Finalizados', stats.finalizados, Icons.check_circle,
          Colors.green),
      _StatItem(
        'Taxa de resolução',
        '${stats.taxaResolucao.toStringAsFixed(0)}%',
        Icons.trending_up,
        AppTheme.senaiRed,
      ),
      _StatItem('Abertos este mês', stats.abertosEsteMes, Icons.calendar_month,
          Colors.blue),
      _StatItem('Usuários cadastrados', stats.usuariosCadastrados,
          Icons.people, Colors.purple),
      _StatItem('Funcionários ativos', stats.funcionariosAtivos,
          Icons.engineering, Colors.green),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => _StatCard(item: items[index]),
    );
  }
}

class _StatItem {
  const _StatItem(this.label, this.value, this.icon, this.color);

  final String label;
  final Object value;
  final IconData icon;
  final Color color;
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.item});

  final _StatItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cardColor(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorderColor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, color: item.color, size: 18),
          ),
          const Spacer(),
          Text(
            '${item.value}',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            item.label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _RecentTicketsSection extends StatelessWidget {
  const _RecentTicketsSection({
    required this.tickets,
    this.onViewAll,
  });

  final List<Ticket> tickets;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorderColor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.list_alt,
                  size: 18, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Chamados recentes',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                child: const Text('Ver todos →'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (tickets.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.folder_open,
                        size: 40,
                        color: AppTheme.senaiRed.withValues(alpha: 0.7)),
                    const SizedBox(height: 8),
                    Text(
                      'Nenhum chamado registrado ainda.',
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...tickets.map(
              (t) => ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                  t.title,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  t.status.label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: Icon(Icons.chevron_right,
                    color: theme.colorScheme.onSurfaceVariant),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TicketDetailScreen(ticketId: t.id),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({required this.stats});

  final DashboardStats stats;

  IconData _iconFor(ProblemType type) {
    switch (type) {
      case ProblemType.eletrica:
        return Icons.bolt;
      case ProblemType.infraestrutura:
        return Icons.account_balance;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = stats.totalChamados;
    final categories = stats.porCategoria.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorderColor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pie_chart_outline,
                  size: 18, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 8),
              Text(
                'Por categoria',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...categories.map((entry) {
            final pct = total == 0 ? 0.0 : (entry.value / total) * 100;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Icon(_iconFor(entry.key),
                      size: 16, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.key.label,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  Text(
                    '${entry.value} (${pct.toStringAsFixed(0)}%)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
