import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/presentation/widgets/theme_palette_selector.dart';

// --- State Model ---
class AppSettingsState {
  final AppThemeOption selectedTheme;
  final ThemeMode themeMode;
  final double fontSize;
  final bool keepScreenAwake;
  final bool showKeySignatures;
  final bool showChorusHighlight;
  final bool autoPlayMidi;
  final String preferredAudioSource;
  final String defaultHymnal;

  const AppSettingsState({
    required this.selectedTheme,
    required this.themeMode,
    required this.fontSize,
    required this.keepScreenAwake,
    required this.showKeySignatures,
    required this.showChorusHighlight,
    required this.autoPlayMidi,
    required this.preferredAudioSource,
    required this.defaultHymnal,
  });

  AppSettingsState copyWith({
    AppThemeOption? selectedTheme,
    ThemeMode? themeMode,
    double? fontSize,
    bool? keepScreenAwake,
    bool? showKeySignatures,
    bool? showChorusHighlight,
    bool? autoPlayMidi,
    String? preferredAudioSource,
    String? defaultHymnal,
  }) {
    return AppSettingsState(
      selectedTheme: selectedTheme ?? this.selectedTheme,
      themeMode: themeMode ?? this.themeMode,
      fontSize: fontSize ?? this.fontSize,
      keepScreenAwake: keepScreenAwake ?? this.keepScreenAwake,
      showKeySignatures: showKeySignatures ?? this.showKeySignatures,
      showChorusHighlight: showChorusHighlight ?? this.showChorusHighlight,
      autoPlayMidi: autoPlayMidi ?? this.autoPlayMidi,
      preferredAudioSource: preferredAudioSource ?? this.preferredAudioSource,
      defaultHymnal: defaultHymnal ?? this.defaultHymnal,
    );
  }
}

// --- Notifier ---
class AppSettingsNotifier extends Notifier<AppSettingsState> {
  @override
  AppSettingsState build() {
    return const AppSettingsState(
      selectedTheme: AppThemeOption(
        id: 'sda_blue',
        name: 'SDA Blue',
        primaryColor: Color(0xFF1E7BB5),
        accentColor: Color(0xFF3893D0),
      ),
      themeMode: ThemeMode.system,
      fontSize: 18.0,
      keepScreenAwake: true,
      showKeySignatures: true,
      showChorusHighlight: true,
      autoPlayMidi: false,
      preferredAudioSource: 'Instrumental (Piano)',
      defaultHymnal: 'Ebizina (Runyoro-Rutooro)',
    );
  }

  void updateTheme(AppThemeOption theme) {
    Future.microtask(() {
      state = state.copyWith(selectedTheme: theme);
    });
  }

  void updateThemeMode(ThemeMode mode) {
    Future.microtask(() {
      state = state.copyWith(themeMode: mode);
    });
  }

  void updateFontSize(double size) {
    Future.microtask(() {
      state = state.copyWith(fontSize: size);
    });
  }

  void toggleKeepScreenAwake(bool val) {
    Future.microtask(() {
      state = state.copyWith(keepScreenAwake: val);
    });
  }

  void toggleShowKeySignatures(bool val) {
    Future.microtask(() {
      state = state.copyWith(showKeySignatures: val);
    });
  }

  void toggleShowChorusHighlight(bool val) {
    Future.microtask(() {
      state = state.copyWith(showChorusHighlight: val);
    });
  }

  void toggleAutoPlayMidi(bool val) {
    Future.microtask(() {
      state = state.copyWith(autoPlayMidi: val);
    });
  }

  void updateAudioSource(String source) {
    Future.microtask(() {
      state = state.copyWith(preferredAudioSource: source);
    });
  }

  void updateDefaultHymnal(String hymnal) {
    Future.microtask(() {
      state = state.copyWith(defaultHymnal: hymnal);
    });
  }
}

// --- Provider ---
final appSettingsProvider =
NotifierProvider<AppSettingsNotifier, AppSettingsState>(
  AppSettingsNotifier.new,
);