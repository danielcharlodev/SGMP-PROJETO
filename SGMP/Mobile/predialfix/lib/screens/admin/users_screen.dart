import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_role.dart';
import '../../services/user_service.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<UserService>();
    final users = context.read<UserService>().listUsers();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: user.isBlocked ? Colors.red.shade100 : null,
            child: Icon(
              user.isBlocked ? Icons.block : Icons.person,
              color: user.isBlocked ? Colors.red : null,
            ),
          ),
          title: Text(user.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.email),
              Text(user.role.label,
                  style: const TextStyle(fontSize: 12)),
              if (user.isBlocked && user.blockReason != null)
                Text(
                  user.blockReason!,
                  style: TextStyle(color: Colors.red.shade700, fontSize: 11),
                ),
            ],
          ),
          isThreeLine: user.isBlocked,
          trailing: PopupMenuButton<String>(
            onSelected: (action) {
              final service = context.read<UserService>();
              switch (action) {
                case 'block':
                  service.setBlocked(
                    user.id,
                    true,
                    reason: 'Bloqueado manualmente pela administração.',
                  );
                case 'unblock':
                  service.setBlocked(user.id, false);
                case 'role_comum':
                  service.updateRole(user.id, UserRole.comum);
                case 'role_tecnico':
                  service.updateRole(user.id, UserRole.tecnico);
                case 'role_admin':
                  service.updateRole(user.id, UserRole.administrador);
              }
            },
            itemBuilder: (context) => [
              if (!user.isBlocked)
                const PopupMenuItem(
                  value: 'block',
                  child: Text('Bloquear usuário'),
                ),
              if (user.isBlocked)
                const PopupMenuItem(
                  value: 'unblock',
                  child: Text('Desbloquear'),
                ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'role_comum',
                child: Text('Permissão: Aluno/Funcionário'),
              ),
              const PopupMenuItem(
                value: 'role_tecnico',
                child: Text('Permissão: Técnico'),
              ),
              const PopupMenuItem(
                value: 'role_admin',
                child: Text('Permissão: Administrador'),
              ),
            ],
          ),
        );
      },
    );
  }
}
