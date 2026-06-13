enum UserRole {
  administrador('Administrador'),
  gerente('Gerente'),
  funcionario('Funcionário'),
  solicitante('Solicitante');

  const UserRole(this.label);
  final String label;
}
