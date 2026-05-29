import 'package:flutter_test/flutter_test.dart';
import 'package:predialfix/app.dart';

void main() {
  testWidgets('Tela de login exibe formulário', (WidgetTester tester) async {
    await tester.pumpWidget(const PredialFixApp());
    await tester.pumpAndSettle();

    expect(find.text('Conectar-se'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });
}
