import 'package:flutter/material.dart';

import '../core/app_theme.dart';

class SenaiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SenaiAppBar({
    super.key,
    this.title,
    this.actions,
    this.showLogo = true,
  });

  final String? title;
  final List<Widget>? actions;
  final bool showLogo;

  @override
  Size get preferredSize => Size.fromHeight(showLogo ? 100 : kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: showLogo ? 100 : null,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(height: 2, color: AppTheme.senaiRed),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLogo)
            Image.asset(
              'assets/images/senai.png',
              height: 48,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.business,
                size: 48,
                color: AppTheme.senaiRed,
              ),
            ),
          if (title != null) ...[
            if (showLogo) const SizedBox(height: 4),
            Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ],
      ),
    );
  }
}
