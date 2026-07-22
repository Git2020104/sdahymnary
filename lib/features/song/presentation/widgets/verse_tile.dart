import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sdahymnary/core/theme/app_settings_provider.dart';

class VerseTile extends ConsumerWidget {
  final String label;
  final String content;
  final bool isChorus;
  final double? fontSize; // Optional override

  const VerseTile({
    super.key,
    required this.label,
    required this.content,
    this.isChorus = false,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final primaryColor = settings.selectedTheme.primaryColor;

    // Fall back to Riverpod setting if no explicit fontSize was passed
    final effectiveFontSize = fontSize ?? settings.fontSize;

    final headerColor = isChorus ? Colors.orange.shade800 : primaryColor;
    final headerText = isChorus ? '[ Chorus ]' : '[ Verse $label ]';

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerText,
            style: TextStyle(
              color: headerColor,
              fontSize: (effectiveFontSize - 4).clamp(10.0, 20.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(
              fontSize: effectiveFontSize,
              color: Colors.grey.shade800,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}