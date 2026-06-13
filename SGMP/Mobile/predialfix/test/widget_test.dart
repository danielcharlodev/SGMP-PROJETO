import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:predialfix/app.dart';

void main() {
  testWidgets('Tela de login exibe formulário', (WidgetTester tester) async {
    await tester.pumpWidget(const PredialFixApp());
    await tester.pumpAndSettle();

    expect(find.text('Conectar-se'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('Login e logout alternam telas sem erro', (WidgetTester tester) async {
    await tester.pumpWidget(const PredialFixApp());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'admin@senai.com',
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      '123456',
    );
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    expect(find.text('Painel Administrativo'), findsOneWidget);
    expect(find.text('Conectar-se'), findsNothing);

    await tester.tap(find.byTooltip('Sair'));
    await tester.pumpAndSettle();

    expect(find.text('Conectar-se'), findsOneWidget);
    expect(find.text('Painel Administrativo'), findsNothing);
  });
}
