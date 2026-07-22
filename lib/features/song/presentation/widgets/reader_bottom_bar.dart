import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sdahymnary/core/theme/app_settings_provider.dart';

class ReaderBottomBar extends ConsumerWidget {
  final VoidCallback onCommentTap;
  final VoidCallback onDialpadTap;

  const ReaderBottomBar({
    super.key,
    required this.onCommentTap,
    required this.onDialpadTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch dynamic theme settings from Riverpod
    final settings = ref.watch(appSettingsProvider);
    final primaryColor = settings.selectedTheme.primaryColor;

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
            onPressed: onCommentTap,
          ),
          const SizedBox(width: 48), // Gap for Floating Play Button
          IconButton(
            icon: const Icon(Icons.dialpad, color: Colors.white),
            onPressed: onDialpadTap,
          ),
        ],
      ),
    );
  }
}