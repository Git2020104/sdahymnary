import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sdahymnary/core/theme/app_settings_provider.dart';
import 'widgets/setting_section_card.dart';
import 'widgets/theme_palette_selector.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const signalWhite = Color(0xFFF4F5F7);

    // Watch the global app settings state
    final settings = ref.watch(appSettingsProvider);
    // Read the notifier to trigger actions
    final notifier = ref.read(appSettingsProvider.notifier);

    final currentPrimaryColor = settings.selectedTheme.primaryColor;

    return Scaffold(
      backgroundColor: signalWhite,
      appBar: AppBar(
        backgroundColor: currentPrimaryColor,
        elevation: 3,
        shadowColor: Colors.black26,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.white.withOpacity(0.18),
            height: 1.0,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          // SECTION 1: Theme & Appearance
          SettingSectionCard(
            title: 'THEME & APPEARANCE',
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Text(
                  'Color Palette',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),

              // Theme Palette Selector
              ThemePaletteSelector(
                selectedThemeId: settings.selectedTheme.id,
                onThemeSelected: (theme) => notifier.updateTheme(theme),
              ),
              const Divider(height: 1, thickness: 0.5),

              // Theme Mode Selector (System / Light / Dark)
              ListTile(
                leading: Icon(Icons.brightness_6, color: currentPrimaryColor),
                title: const Text('Appearance Mode'),
                subtitle: Text(
                  settings.themeMode == ThemeMode.system
                      ? 'System Default'
                      : settings.themeMode == ThemeMode.dark
                      ? 'Dark Mode'
                      : 'Light Mode',
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(
                      value: ThemeMode.light,
                      icon: Icon(Icons.wb_sunny_outlined, size: 16),
                    ),
                    ButtonSegment(
                      value: ThemeMode.system,
                      icon: Icon(Icons.brightness_auto, size: 16),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      icon: Icon(Icons.nights_stay_outlined, size: 16),
                    ),
                  ],
                  selected: {settings.themeMode},
                  onSelectionChanged: (newSelection) {
                    notifier.updateThemeMode(newSelection.first);
                  },
                  style: const ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ],
          ),

          // SECTION 2: Hymn Reader Settings
          SettingSectionCard(
            title: 'HYMN READER',
            children: [
              // Font Size Adjuster
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Lyrics Font Size',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Text(
                      '${settings.fontSize.toInt()} sp',
                      style: TextStyle(
                        color: currentPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Slider(
                value: settings.fontSize,
                min: 14.0,
                max: 30.0,
                divisions: 8,
                activeColor: currentPrimaryColor,
                label: '${settings.fontSize.toInt()} sp',
                onChanged: (val) => notifier.updateFontSize(val),
              ),

              // Live Lyrics Preview Box
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: signalWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  'Sabiiti erukwera, Kampebwa y\'omuhendo...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: settings.fontSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, thickness: 0.5),

              // Keep Screen Awake Switch
              SwitchListTile(
                secondary: Icon(
                  Icons.wb_incandescent_outlined,
                  color: currentPrimaryColor,
                ),
                title: const Text('Keep Screen Awake'),
                subtitle: const Text(
                  'Prevents screen from turning off while reading',
                  style: TextStyle(fontSize: 12),
                ),
                value: settings.keepScreenAwake,
                activeColor: currentPrimaryColor,
                onChanged: (val) => notifier.toggleKeepScreenAwake(val),
              ),
              const Divider(height: 1, thickness: 0.5),

              // Key Signature Toggle
              SwitchListTile(
                secondary: Icon(Icons.music_note, color: currentPrimaryColor),
                title: const Text('Show Key Signatures'),
                subtitle: const Text(
                  'Display musical keys e.g., Doh is F',
                  style: TextStyle(fontSize: 12),
                ),
                value: settings.showKeySignatures,
                activeColor: currentPrimaryColor,
                onChanged: (val) => notifier.toggleShowKeySignatures(val),
              ),
              const Divider(height: 1, thickness: 0.5),

              // Highlight Chorus Toggle
              SwitchListTile(
                secondary: Icon(Icons.format_quote, color: currentPrimaryColor),
                title: const Text('Highlight Chorus / Refrain'),
                subtitle: const Text(
                  'Apply distinct visual style to choruses',
                  style: TextStyle(fontSize: 12),
                ),
                value: settings.showChorusHighlight,
                activeColor: currentPrimaryColor,
                onChanged: (val) => notifier.toggleShowChorusHighlight(val),
              ),
            ],
          ),

          // SECTION 3: Audio & Playback
          SettingSectionCard(
            title: 'AUDIO & TUNE PLAYBACK',
            children: [
              SwitchListTile(
                secondary: Icon(
                  Icons.play_circle_outline,
                  color: currentPrimaryColor,
                ),
                title: const Text('Auto-Play Tune'),
                subtitle: const Text(
                  'Automatically play hymn melody on screen open',
                  style: TextStyle(fontSize: 12),
                ),
                value: settings.autoPlayMidi,
                activeColor: currentPrimaryColor,
                onChanged: (val) => notifier.toggleAutoPlayMidi(val),
              ),
              const Divider(height: 1, thickness: 0.5),

              ListTile(
                leading: Icon(Icons.graphic_eq, color: currentPrimaryColor),
                title: const Text('Preferred Audio Source'),
                subtitle: Text(
                  settings.preferredAudioSource,
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  _showAudioSourcePicker(context, ref);
                },
              ),
            ],
          ),

          // SECTION 4: General & Language
          SettingSectionCard(
            title: 'GENERAL',
            children: [
              ListTile(
                leading: Icon(Icons.menu_book, color: currentPrimaryColor),
                title: const Text('Default Hymnal'),
                subtitle: Text(
                  settings.defaultHymnal,
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  _showHymnalPicker(context, ref);
                },
              ),
              const Divider(height: 1, thickness: 0.5),

              ListTile(
                leading: Icon(Icons.info_outline, color: currentPrimaryColor),
                title: const Text('About SDA Tendo'),
                subtitle: const Text(
                  'Version 2.4.0 • Build 2026',
                  style: TextStyle(fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'SDA Tendo Hymnal',
                    applicationVersion: 'v2.4.0',
                    applicationIcon: CircleAvatar(
                      backgroundColor: currentPrimaryColor,
                      child: const Icon(Icons.menu_book, color: Colors.white),
                    ),
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                        'A multi-language Seventh-day Adventist Hymnal application designed for worship, choir study, and devotion.',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Audio Source Picker Modal
  void _showAudioSourcePicker(BuildContext context, WidgetRef ref) {
    final settings = ref.read(appSettingsProvider);
    final notifier = ref.read(appSettingsProvider.notifier);
    final primaryColor = settings.selectedTheme.primaryColor;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Select Preferred Audio Source',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              ListTile(
                title: const Text('Instrumental (Piano)'),
                trailing: settings.preferredAudioSource == 'Instrumental (Piano)'
                    ? Icon(Icons.check, color: primaryColor)
                    : null,
                onTap: () {
                  notifier.updateAudioSource('Instrumental (Piano)');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Organ Accompaniment'),
                trailing: settings.preferredAudioSource == 'Organ Accompaniment'
                    ? Icon(Icons.check, color: primaryColor)
                    : null,
                onTap: () {
                  notifier.updateAudioSource('Organ Accompaniment');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Midi Synthesizer'),
                trailing: settings.preferredAudioSource == 'Midi Synthesizer'
                    ? Icon(Icons.check, color: primaryColor)
                    : null,
                onTap: () {
                  notifier.updateAudioSource('Midi Synthesizer');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Default Hymnal Language Picker Modal
  void _showHymnalPicker(BuildContext context, WidgetRef ref) {
    final settings = ref.read(appSettingsProvider);
    final notifier = ref.read(appSettingsProvider.notifier);
    final primaryColor = settings.selectedTheme.primaryColor;

    final hymnals = [
      'Ebizina (Runyoro-Rutooro)',
      'Nyimbo Za Kristo (Swahili)',
      'SDA Church Hymnal (English)',
      'Enyimba Z\'Olukristo (Luganda)',
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Select Default Hymnal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              ...hymnals.map(
                    (h) => ListTile(
                  title: Text(h),
                  trailing: settings.defaultHymnal == h
                      ? Icon(Icons.check, color: primaryColor)
                      : null,
                  onTap: () {
                    notifier.updateDefaultHymnal(h);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}