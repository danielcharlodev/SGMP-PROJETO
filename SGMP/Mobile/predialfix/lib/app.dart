import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';
import 'services/theme_service.dart';
import 'services/ticket_service.dart';
import 'services/user_service.dart';

class PredialFixApp extends StatelessWidget {
  const PredialFixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => TicketService()),
        ChangeNotifierProvider(create: (_) => UserService()),
      ],
      child: Consumer2<ThemeService, AuthService>(
        builder: (context, themeService, auth, _) {
          return MaterialApp(
            title: 'PredialFix - SGMP',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeService.themeMode,
            home: auth.isLoggedIn ? const HomeScreen() : const LoginScreen(),
          );
        },
      ),
    );
  }
}
