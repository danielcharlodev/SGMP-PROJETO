enum TicketPriority {
  baixa('Baixa'),
  media('Média'),
  alta('Alta'),
  urgente('Urgente');

  const TicketPriority(this.label);
  final String label;
}
