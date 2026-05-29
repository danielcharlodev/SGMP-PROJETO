enum UserRole {
  comum('Aluno / Funcionário'),
  tecnico('Responsável técnico'),
  administrador('Administrador');

  const UserRole(this.label);
  final String label;
}
