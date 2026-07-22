import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sdahymnary/core/theme/app_settings_provider.dart';

class HomeBottomBar extends ConsumerWidget {
  final VoidCallback? onCategoriesTap;
  final VoidCallback? onFavoritesTap;

  const HomeBottomBar({
    super.key,
    this.onCategoriesTap,
    this.onFavoritesTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read active primary color from Riverpod
    final settings = ref.watch(appSettingsProvider);
    final primaryColor = settings.selectedTheme.primaryColor;

    return BottomAppBar(
      color: primaryColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: InkWell(
              onTap: onCategoriesTap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.grid_view_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Categories (27)',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 48), // Gap for Docked Reader FAB
          Expanded(
            child: InkWell(
              onTap: onFavoritesTap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.folder, color: Colors.white, size: 20),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Favorites (1)',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}