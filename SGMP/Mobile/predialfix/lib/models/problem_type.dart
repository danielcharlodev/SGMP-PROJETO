enum ProblemType {
  eletrica('Elétrica'),
  hidraulica('Hidráulica'),
  arCondicionado('Ar-condicionado'),
  estrutural('Estrutural'),
  limpeza('Limpeza'),
  outros('Outros');

  const ProblemType(this.label);
  final String label;
}
