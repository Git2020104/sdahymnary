import 'package:flutter/material.dart';

class NumericDialpadSheet extends StatefulWidget {
  const NumericDialpadSheet({super.key});

  @override
  State<NumericDialpadSheet> createState() => _NumericDialpadSheetState();
}

class _NumericDialpadSheetState extends State<NumericDialpadSheet> {
  String inputNumber = '';

  void _onKeyPress(String digit) {
    if (inputNumber.length < 4) {
      setState(() => inputNumber += digit);
    }
  }

  void _onBackspace() {
    if (inputNumber.isNotEmpty) {
      setState(
        () => inputNumber = inputNumber.substring(0, inputNumber.length - 1),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(24.0),
      //mainAxisSize: MainAxisSize.min,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Number Display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              inputNumber.isEmpty ? 'Type Hymn #' : inputNumber,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: inputNumber.isEmpty
                    ? theme.colorScheme.onSurface.withOpacity(0.4)
                    : theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Grid Keypad
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.6,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              if (index == 9) {
                return IconButton(
                  onPressed: _onBackspace,
                  icon: const Icon(Icons.backspace_outlined),
                );
              }
              if (index == 10) {
                return _buildDialButton('0', theme);
              }
              if (index == 11) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: inputNumber.isEmpty
                      ? null
                      : () {
                          Navigator.pop(context);
                          // Jump logic goes here
                        },
                  child: const Text(
                    'GO',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }
              return _buildDialButton('${index + 1}', theme);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDialButton(String digit, ThemeData theme) {
    return InkWell(
      onTap: () => _onKeyPress(digit),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          digit,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
