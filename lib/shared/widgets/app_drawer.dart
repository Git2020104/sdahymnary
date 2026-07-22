import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sdahymnary/core/theme/app_settings_provider.dart';
import '../../features/settings/presentation/settings_screen.dart';

class AppDrawer extends ConsumerWidget {
  final String? activeHymnal;
  final ValueChanged<String>? onHymnalSelected;

  const AppDrawer({
    super.key,
    this.activeHymnal,
    this.onHymnalSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch settings state from Riverpod
    final settings = ref.watch(appSettingsProvider);
    final primaryColor = settings.selectedTheme.primaryColor;
    final currentHymnal = activeHymnal ?? settings.defaultHymnal;

    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: primaryColor),
            accountName: const Text(
              'Multi-Hymnal',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(
              'Active: $currentHymnal',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.menu_book_rounded,
                color: primaryColor,
                size: 32,
              ),
            ),
          ),

          // Navigation Links
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.home_outlined, color: primaryColor),
                  title: const Text('Home / Dialpad'),
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.collections_bookmark_outlined,
                    color: primaryColor,
                  ),
                  title: const Text('Select Hymnal'),
                  trailing: const Icon(Icons.arrow_drop_down),
                  onTap: () {
                    _showHymnalSelector(context, ref);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite_outline,
                    color: primaryColor,
                  ),
                  title: const Text('Favorites'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.grid_view_rounded,
                    color: primaryColor,
                  ),
                  title: const Text('Categories & Topics'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.wb_sunny_outlined,
                    color: primaryColor,
                  ),
                  title: const Text('Daily Devotional'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context); // Close Drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          // Footer Info
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                const Icon(Icons.church_outlined, size: 18, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showHymnalSelector(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(appSettingsProvider.notifier);

    showDialog(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Select Hymnbook'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(dialogContext); // 1. Close dialog first

              // 2. Schedule state change right after the frame finishes
              WidgetsBinding.instance.addPostFrameCallback((_) {
                const hymnal = 'Ebizina (Runyoro-Rutooro)';
                onHymnalSelected?.call(hymnal);
                notifier.updateDefaultHymnal(hymnal);
              });
            },
            child: const Text('Ebizina (Runyoro-Rutooro)'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(dialogContext);

              WidgetsBinding.instance.addPostFrameCallback((_) {
                const hymnal = 'Nyimbo za Kristo (Swahili)';
                onHymnalSelected?.call(hymnal);
                notifier.updateDefaultHymnal(hymnal);
              });
            },
            child: const Text('Nyimbo za Kristo (Swahili)'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(dialogContext);

              WidgetsBinding.instance.addPostFrameCallback((_) {
                const hymnal = 'Church Hymnal (English)';
                onHymnalSelected?.call(hymnal);
                notifier.updateDefaultHymnal(hymnal);
              });
            },
            child: const Text('Church Hymnal (English)'),
          ),
        ],
      ),
    );
  }
}