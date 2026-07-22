import 'package:flutter/material.dart';
import '../../features/settings/presentation/widgets/theme_palette_selector.dart';

class AppSettings extends ChangeNotifier {
  // Theme Properties
  AppThemeOption _selectedTheme = availableThemes[0]; // SDA Blue by default
  ThemeMode _themeMode = ThemeMode.system;

  // Hymn Reader Properties
  double _fontSize = 18.0;
  bool _keepScreenAwake = true;
  bool _showKeySignatures = true;
  bool _showChorusHighlight = true;

  // Audio & General
  bool _autoPlayMidi = false;
  String _preferredAudioSource = 'Instrumental (Piano)';
  String _defaultHymnal = 'Ebizina (Runyoro-Rutooro)';

  // Getters
  AppThemeOption get selectedTheme => _selectedTheme;
  Color get primaryColor => _selectedTheme.primaryColor;
  Color get accentColor => _selectedTheme.accentColor;
  ThemeMode get themeMode => _themeMode;
  double get fontSize => _fontSize;
  bool get keepScreenAwake => _keepScreenAwake;
  bool get showKeySignatures => _showKeySignatures;
  bool get showChorusHighlight => _showChorusHighlight;
  bool get autoPlayMidi => _autoPlayMidi;
  String get preferredAudioSource => _preferredAudioSource;
  String get defaultHymnal => _defaultHymnal;

  // Modifiers
  void updateTheme(AppThemeOption theme) {
    _selectedTheme = theme;
    notifyListeners();
  }

  void updateThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void updateFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }

  void toggleKeepScreenAwake(bool value) {
    _keepScreenAwake = value;
    notifyListeners();
  }

  void toggleShowKeySignatures(bool value) {
    _showKeySignatures = value;
    notifyListeners();
  }

  void toggleShowChorusHighlight(bool value) {
    _showChorusHighlight = value;
    notifyListeners();
  }

  void toggleAutoPlayMidi(bool value) {
    _autoPlayMidi = value;
    notifyListeners();
  }

  void updateAudioSource(String source) {
    _preferredAudioSource = source;
    notifyListeners();
  }

  void updateDefaultHymnal(String hymnal) {
    _defaultHymnal = hymnal;
    notifyListeners();
  }
}

/// Scope wrapper allowing any widget in the tree to read or update settings
class AppSettingsScope extends InheritedNotifier<AppSettings> {
  const AppSettingsScope({
    super.key,
    required AppSettings settings,
    required super.child,
  }) : super(notifier: settings);

  static AppSettings of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppSettingsScope>()!
        .notifier!;
  }
}