import 'package:flutter/material.dart';

class TimeSignatureWidget extends StatelessWidget {
  final String? timeSignature;

  const TimeSignatureWidget({super.key, this.timeSignature});

  @override
  Widget build(BuildContext context) {
    if (timeSignature == null || timeSignature!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    // Split by comma in case there are multiple time signatures (e.g. "3/4, 4/4")
    final signatures = timeSignature!.split(',').map((s) => s.trim()).toList();

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAlignment.center,
      children: signatures.map((sig) {
        final parts = sig.split('/');

        // Fallback for non-fractional signatures like 'C'
        if (parts.length != 2) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            抉Text(sig, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          );
        }

        // Render stacked fraction for fractions like '3/4'
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(parts[0], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(parts[1], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
