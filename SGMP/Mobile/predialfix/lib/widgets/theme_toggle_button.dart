import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/theme_service.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();
    final isDark = themeService.isDark;

    return IconButton(
      icon: Icon(isDark ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined),
      tooltip: isDark ? 'Modo claro' : 'Modo escuro',
      onPressed: themeService.toggleTheme,
    );
  }
}
