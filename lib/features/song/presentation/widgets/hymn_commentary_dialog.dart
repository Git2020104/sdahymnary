import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sdahymnary/core/theme/app_settings_provider.dart';

class HymnCommentaryDialog extends ConsumerWidget {
  final String songNumber;

  const HymnCommentaryDialog({
    super.key,
    required this.songNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch primary color from Riverpod settings
    final settings = ref.watch(appSettingsProvider);
    final primaryColor = settings.selectedTheme.primaryColor;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 8,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Comments on song: $songNumber',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(height: 16),
            Text(
              'Summary',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Content not available!',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
            ),
            const SizedBox(height: 20),
            Text(
              'Scripture',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Mark 2:27\n"The Sabbath was made for the good of human beings; they were not made for the Sabbath."',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}