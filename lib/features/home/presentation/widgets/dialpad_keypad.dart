import 'package:flutter/material.dart';

class DialpadKeypad extends StatelessWidget {
  final ValueChanged<String> onKeyPressed;
  final VoidCallback? onHandleDragUp; // Callback when pill is dragged up or tapped

  const DialpadKeypad({
    super.key,
    required this.onKeyPressed,
    this.onHandleDragUp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF7FBFF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Draggable Handle Pill Area
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragEnd: (details) {
              // Trigger when user flicks/drags upward
              if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
                onHandleDragUp?.call();
              }
            },
            onTap: onHandleDragUp,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Keypad Grid Container
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
            ),
            padding: const EdgeInsets.only(
              top: 12,
              bottom: 85,
              left: 50,
              right: 50,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                _buildKeypadRow(['1', '2', '3', 'BACK']),
                const SizedBox(height: 8),
                _buildKeypadRow(['4', '5', '6', 'C']),
                const SizedBox(height: 8),
                _buildKeypadRow(['7', '8', '9', '0']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) {
        return Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            constraints: const BoxConstraints(maxWidth: 54, maxHeight: 54),
            child: AspectRatio(
              aspectRatio: 1,
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                elevation: 12,
                shadowColor: Colors.black26,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => onKeyPressed(key),
                  child: Center(
                    child: key == 'BACK'
                        ? const Icon(
                      Icons.backspace_outlined,
                      color: Color(0xFF1E7BB5),
                      size: 18,
                    )
                        : Text(
                      key,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF1E7BB5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}