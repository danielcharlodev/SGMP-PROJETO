import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/app_theme.dart';
import '../../models/app_user.dart';
import '../../models/user_role.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _searchController = TextEditingController();
  UserRole? _roleFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AppUser> _loadUsers(UserService service) {
    return service.searchUsers(
      query: _searchController.text,
      roleFilter: _roleFilter,
    );
  }

  Future<void> _editUser(AppUser user) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _UserEditSheet(user: user),
    );
    if (result == true && mounted) setState(() {});
  }

  Future<void> _deleteUser(AppUser user) async {
    final currentUser = context.read<AuthService>().currentUser!;
    if (user.id == currentUser.id) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você não pode excluir sua própria conta.')),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir usuário?'),
        content: Text(
          'Deseja excluir ${user.name}? Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    final deleted = context.read<UserService>().deleteUser(user.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          deleted ? 'Usuário excluído.' : 'Não foi possível excluir.',
        ),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    context.watch<UserService>();
    final users = _loadUsers(context.read<UserService>());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Controle de acessos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Pesquise por nome, CPF, e-mail ou tipo de usuário.',
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar usuário...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('Todos'),
                      selected: _roleFilter == null,
                      onSelected: (_) => setState(() => _roleFilter = null),
                    ),
                    const SizedBox(width: 8),
                    ...UserRole.values.map(
                      (role) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(role.label),
                          selected: _roleFilter == role,
                          onSelected: (v) => setState(
                            () => _roleFilter = v ? role : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: users.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person_search,
                          size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      const Text('Nenhum usuário encontrado'),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: user.isBlocked
                              ? Colors.red.shade100
                              : AppTheme.senaiRed.withValues(alpha: 0.1),
                          child: Icon(
                            user.isBlocked ? Icons.block : Icons.person,
                            color: user.isBlocked
                                ? Colors.red
                                : AppTheme.senaiRed,
                          ),
                        ),
                        title: Text(user.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.email),
                            Text('CPF: ${user.formattedCpf}',
                                style: const TextStyle(fontSize: 12)),
                            Text(user.role.label,
                                style: const TextStyle(fontSize: 12)),
                            if (user.isBlocked && user.blockReason != null)
                              Text(
                                user.blockReason!,
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontSize: 11,
                                ),
                              ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton<String>(
                          onSelected: (action) {
                            final service = context.read<UserService>();
                            switch (action) {
                              case 'edit':
                                _editUser(user);
                              case 'delete':
                                _deleteUser(user);
                              case 'block':
                                service.setBlocked(
                                  user.id,
                                  true,
                                  reason:
                                      'Bloqueado manualmente pela administração.',
                                );
                                setState(() {});
                              case 'unblock':
                                service.setBlocked(user.id, false);
                                setState(() {});
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Editar usuário'),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Excluir usuário'),
                            ),
                            const PopupMenuDivider(),
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _UserEditSheet extends StatefulWidget {
  const _UserEditSheet({required this.user});

  final AppUser user;

  @override
  State<_UserEditSheet> createState() => _UserEditSheetState();
}

class _UserEditSheetState extends State<_UserEditSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _cpfController;
  late UserRole _role;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _cpfController =
        TextEditingController(text: widget.user.formattedCpf);
    _role = widget.user.role;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final cpf = _cpfController.text.replaceAll(RegExp(r'\D'), '');

    if (name.isEmpty || email.isEmpty || cpf.length != 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha nome, e-mail e CPF válido.')),
      );
      return;
    }

    context.read<UserService>().updateUser(
          userId: widget.user.id,
          name: name,
          email: email,
          cpf: cpf,
          role: _role,
        );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Editar usuário',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nome'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'E-mail'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _cpfController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(labelText: 'CPF'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<UserRole>(
            value: _role,
            decoration: const InputDecoration(labelText: 'Tipo de acesso'),
            items: UserRole.values
                .map(
                  (r) => DropdownMenuItem(value: r, child: Text(r.label)),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) setState(() => _role = v);
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _save, child: const Text('Salvar')),
        ],
      ),
    );
  }
}
