import 'problem_type.dart';

class DashboardStats {
  const DashboardStats({
    required this.totalChamados,
    required this.pendentes,
    required this.emAndamento,
    required this.finalizados,
    required this.taxaResolucao,
    required this.abertosEsteMes,
    required this.usuariosCadastrados,
    required this.funcionariosAtivos,
    required this.porCategoria,
  });

  final int totalChamados;
  final int pendentes;
  final int emAndamento;
  final int finalizados;
  final double taxaResolucao;
  final int abertosEsteMes;
  final int usuariosCadastrados;
  final int funcionariosAtivos;
  final Map<ProblemType, int> porCategoria;
}
