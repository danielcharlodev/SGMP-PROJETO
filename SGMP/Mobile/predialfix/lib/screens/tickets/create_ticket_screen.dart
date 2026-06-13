import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants.dart';
import '../../models/problem_type.dart';
import '../../models/ticket_priority.dart';
import '../../services/auth_service.dart';
import '../../services/ticket_service.dart';
import '../../widgets/theme_toggle_button.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _location = AppConstants.locations.first;
  ProblemType _type = ProblemType.eletrica;
  TicketPriority _priority = TicketPriority.media;
  bool _saving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final user = context.read<AuthService>().currentUser!;
      context.read<TicketService>().createTicket(
            author: user,
            title: _titleController.text,
            description: _descriptionController.text,
            location: _location,
            problemType: _type,
            priority: _priority,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chamado registrado com sucesso!')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abrir chamado'),
        actions: const [ThemeToggleButton()],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Descreva o problema real do local. Chamados falsos (trote) '
              'podem resultar em bloqueio do seu acesso.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título resumido',
                hintText: 'Ex.: Ar-condicionado não funciona',
              ),
              validator: (v) =>
                  v == null || v.trim().length < 5 ? 'Mínimo 5 caracteres' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Descrição do problema',
              ),
              validator: (v) => v == null || v.trim().length < 10
                  ? 'Descreva com mais detalhes'
                  : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _location,
              decoration: const InputDecoration(labelText: 'Local'),
              items: AppConstants.locations
                  .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _location = v);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ProblemType>(
              value: _type,
              decoration:
                  const InputDecoration(labelText: 'Tipo de problema'),
              items: ProblemType.values
                  .map((t) => DropdownMenuItem(value: t, child: Text(t.label)))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _type = v);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TicketPriority>(
              value: _priority,
              decoration: const InputDecoration(labelText: 'Prioridade'),
              items: TicketPriority.values
                  .map((p) => DropdownMenuItem(value: p, child: Text(p.label)))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _priority = v);
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saving ? null : _submit,
              child: _saving
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Registrar chamado'),
            ),
          ],
        ),
      ),
    );
  }
}
