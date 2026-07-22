import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sdahymnary/core/theme/app_settings_provider.dart';

class SideActionButtons extends ConsumerWidget {
  final VoidCallback? onTextSizeTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onLanguageTap;
  final bool isFavorite;

  const SideActionButtons({
    super.key,
    this.onTextSizeTap,
    this.onShareTap,
    this.onFavoriteTap,
    this.onLanguageTap,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read dynamic primary color from Riverpod settings
    final settings = ref.watch(appSettingsProvider);
    final primaryColor = settings.selectedTheme.primaryColor;

    return Column(
      children: [
        _buildCircleButton(
          'Aa',
          color: primaryColor,
          isText: true,
          onTap: onTextSizeTap,
        ),
        const SizedBox(height: 10),
        _buildCircleButton(
          '',
          icon: Icons.share_outlined,
          color: primaryColor,
          onTap: onShareTap,
        ),
        const SizedBox(height: 10),
        _buildCircleButton(
          '',
          icon: isFavorite ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
          color: Colors.orange,
          onTap: onFavoriteTap,
        ),
        const SizedBox(height: 10),
        _buildCircleButton(
          'ENG',
          color: primaryColor,
          isText: true,
          onTap: onLanguageTap,
        ),
      ],
    );
  }

  Widget _buildCircleButton(
      String text, {
        IconData? icon,
        required Color color,
        bool isText = false,
        VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: isText
              ? Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          )
              : Icon(icon, color: color, size: 18),
        ),
      ),
    );
  }
}