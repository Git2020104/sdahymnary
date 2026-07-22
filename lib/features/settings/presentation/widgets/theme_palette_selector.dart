import 'package:flutter/material.dart';

class AppThemeOption {
  final String id;
  final String name;
  final Color primaryColor;
  final Color accentColor;

  const AppThemeOption({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.accentColor,
  });
}

// Plethora of predefined hymnal themes
const List<AppThemeOption> availableThemes = [
  AppThemeOption(
    id: 'sda_blue',
    name: 'SDA Blue',
    primaryColor: Color(0xFF1E7BB5),
    accentColor: Color(0xFF3893D0),
  ),
  AppThemeOption(
    id: 'emerald_sabbath',
    name: 'Emerald',
    primaryColor: Color(0xFF1B6B50),
    accentColor: Color(0xFF289672),
  ),
  AppThemeOption(
    id: 'burgundy_hymnal',
    name: 'Burgundy',
    primaryColor: Color(0xFF8B1E3F),
    accentColor: Color(0xFFB82855),
  ),
  AppThemeOption(
    id: 'royal_purple',
    name: 'Royal Purple',
    primaryColor: Color(0xFF5A2A82),
    accentColor: Color(0xFF7E3CB8),
  ),
  AppThemeOption(
    id: 'deep_amber',
    name: 'Deep Amber',
    primaryColor: Color(0xFFC67D0A),
    accentColor: Color(0xFFE5981A),
  ),
  AppThemeOption(
    id: 'midnight_slate',
    name: 'Slate Grey',
    primaryColor: Color(0xFF34495E),
    accentColor: Color(0xFF4A6572),
  ),
];

class ThemePaletteSelector extends StatelessWidget {
  final String selectedThemeId;
  final ValueChanged<AppThemeOption> onThemeSelected;

  const ThemePaletteSelector({
    super.key,
    required this.selectedThemeId,
    required this.onThemeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: availableThemes.length,
        itemBuilder: (context, index) {
          final theme = availableThemes[index];
          final isSelected = theme.id == selectedThemeId;

          return GestureDetector(
            onTap: () => onThemeSelected(theme),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              padding: const EdgeInsets.all(8),
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? theme.primaryColor : Colors.grey.shade300,
                  width: isSelected ? 2.5 : 1,
                ),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: theme.primaryColor.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
                    : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Dual Color Circle Preview
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: theme.primaryColor,
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  FittedBox(
                    child: Text(
                      theme.name,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected
                            ? theme.primaryColor
                            : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}