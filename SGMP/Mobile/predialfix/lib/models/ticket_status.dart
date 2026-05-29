enum TicketStatus {
  aberto('Em aberto'),
  emExecucao('Em execução'),
  concluido('Concluído'),
  cancelado('Cancelado');

  const TicketStatus(this.label);
  final String label;
}
