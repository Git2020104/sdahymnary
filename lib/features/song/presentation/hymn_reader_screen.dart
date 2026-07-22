import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sdahymnary/core/theme/app_settings_provider.dart';
import '../../../../shared/widgets/app_drawer.dart';
import 'widgets/hymn_commentary_dialog.dart';
import 'widgets/reader_bottom_bar.dart';
import 'widgets/side_action_buttons.dart';
import 'widgets/verse_tile.dart';

class HymnReaderScreen extends ConsumerStatefulWidget {
  final String number;
  final String? title;
  final String? keySig;

  const HymnReaderScreen({
    super.key,
    required this.number,
    this.title,
    this.keySig,
  });

  @override
  ConsumerState<HymnReaderScreen> createState() => _HymnReaderScreenState();
}

class _HymnReaderScreenState extends ConsumerState<HymnReaderScreen> {
  void _openCommentaryDialog() {
    showDialog(
      context: context,
      builder: (_) => HymnCommentaryDialog(songNumber: widget.number),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Read active settings and notifier from Riverpod
    final settings = ref.watch(appSettingsProvider);
    final notifier = ref.read(appSettingsProvider.notifier);

    final primaryColor = settings.selectedTheme.primaryColor;
    const signalWhite = Color(0xFFF4F5F7);

    final songTitle = widget.title ?? 'Sabiiti Erukwera - Sabbath Day';
    final keyNotation = widget.keySig ?? 'Doh:';

    return Scaffold(
      backgroundColor: signalWhite,
      drawer: AppDrawer(
        activeHymnal: settings.defaultHymnal,
        onHymnalSelected: (newHymnal) {
          notifier.updateDefaultHymnal(newHymnal);
        },
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 3,
        shadowColor: Colors.black26,
        leading: Builder(
          builder: (builderContext) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(builderContext).openDrawer(),
          ),
        ),
        title: Text(
          'Song no.${widget.number} - $songTitle',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        child: Stack(
          children: [
            // Pure White Hymn Content Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 90),
                  children: [
                    Text(
                      'Sabiiti Erukwera',
                      style: TextStyle(
                        fontSize: settings.fontSize + 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Sabbath Day',
                      style: TextStyle(
                        fontSize: settings.fontSize - 2,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    if (settings.showKeySignatures) ...[
                      Text(
                        keyNotation,
                        style: TextStyle(
                          fontSize: settings.fontSize - 2,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                    const Divider(height: 28, thickness: 1),

                    const VerseTile(
                      label: '1',
                      content:
                      'Sabiiti erukwera, (E)kampebwa\ny\'omuhendo; Ija, Ija garuka,\nTuhumule itwena.',
                    ),
                    const VerseTile(
                      label: '2',
                      content:
                      '(O)mulimo (o)bugulihwa, Tuserrege\nRuhanga; Ha meeza ya Isiitwe,\nTuhurre ebigambo.',
                    ),
                    const VerseTile(
                      label: '3',
                      content:
                      'Ntukulinda Ai Yesu, Tuh(e) emigisa\nnyingi; Ikiriza enjiri, Ikar(a) omu nda\nzaitu.',
                    ),
                    const VerseTile(
                      label: '4',
                      content:
                      '(E)kigambo kyawe hati, Kisingul(e)\nemituma; Tuliise, Ai Yesu,\nEby\'okulya by\'omwoyo.',
                    ),
                    const VerseTile(
                      label: '5',
                      content:
                      'Mukama akasumi, Nikaija\ntukonyare; Ha Sabbath(i) etahwaho,',
                    ),
                  ],
                ),
              ),
            ),

            // Floating Side Action Toolbar
            Positioned(
              right: 12,
              top: 16,
              child: SideActionButtons(
                onTextSizeTap: () {},
                onShareTap: () {},
                onFavoriteTap: () {},
                onLanguageTap: () {},
              ),
            ),
          ],
        ),
      ),

      // Docked Audio Control Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 6,
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.play_arrow, color: Colors.white, size: 34),
      ),

      // Reader Bottom Action Bar
      bottomNavigationBar: ReaderBottomBar(
        onCommentTap: _openCommentaryDialog,
        onDialpadTap: () => Navigator.pop(context),
      ),
    );
  }
}