import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sdahymnary/core/theme/app_settings_provider.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../song/presentation/hymn_reader_screen.dart';
import 'widgets/dialpad_display_card.dart';
import 'widgets/dialpad_keypad.dart';
import 'widgets/home_bottom_bar.dart';
import 'widgets/hymn_list_sheet.dart';

class HymnalHomeScreen extends ConsumerStatefulWidget {
  const HymnalHomeScreen({super.key});

  @override
  ConsumerState<HymnalHomeScreen> createState() => _HymnalHomeScreenState();
}

class _HymnalHomeScreenState extends ConsumerState<HymnalHomeScreen> {
  // Local Ephemeral UI State
  String enteredNumber = '';
  bool isSearching = false;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onDialpadPressed(String value) {
    setState(() {
      if (value == 'C') {
        enteredNumber = '';
      } else if (value == 'BACK') {
        if (enteredNumber.isNotEmpty) {
          enteredNumber = enteredNumber.substring(0, enteredNumber.length - 1);
        }
      } else {
        if (enteredNumber.length < 3) {
          enteredNumber += value;
        }
      }
    });
  }

  void _openHymnListSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        return HymnListSheet(
          searchQuery: searchQuery,
          onSearchChanged: (query) {
            setState(() => searchQuery = query);
          },
        );
      },
    ).then((_) {
      if (mounted && isSearching && searchQuery.isEmpty) {
        setState(() => isSearching = false);
      }
    });
  }

  void _openReader() {
    if (enteredNumber.isNotEmpty && enteredNumber != '0') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HymnReaderScreen(
            number: enteredNumber,
            title: enteredNumber == '56'
                ? 'Sabiiti Erukwera - Sabbath Day'
                : null,
            keySig: 'Doh',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Read active settings from Riverpod
    final settings = ref.watch(appSettingsProvider);
    final notifier = ref.read(appSettingsProvider.notifier);

    final primaryColor = settings.selectedTheme.primaryColor;
    final activeHymnal = settings.defaultHymnal;

    return Scaffold(
      backgroundColor: primaryColor,
      drawer: AppDrawer(
        activeHymnal: activeHymnal,
        onHymnalSelected: (newHymnal) {
          notifier.updateDefaultHymnal(newHymnal);
        },
      ),
      extendBody: true,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 3,
        shadowColor: Colors.black26,
        leading: Builder(
          builder: (builderContext) => IconButton(
            icon: Icon(
              isSearching ? Icons.arrow_back : Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              if (isSearching) {
                setState(() {
                  isSearching = false;
                  searchQuery = '';
                  _searchController.clear();
                });
              } else {
                Scaffold.of(builderContext).openDrawer();
              }
            },
          ),
        ),

        // Search Input or Title Display
        title: isSearching
            ? Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white.withOpacity(0.35),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: 'Search title or number...',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 13,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white70,
                size: 18,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onChanged: (val) {
              setState(() => searchQuery = val);
            },
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SDA Tendo',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              activeHymnal,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              isSearching ? Icons.clear : Icons.search,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              if (isSearching) {
                setState(() {
                  _searchController.clear();
                  searchQuery = '';
                });
              } else {
                setState(() => isSearching = true);
                _openHymnListSheet();
              }
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.white.withOpacity(0.18),
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 10,
                    child: DialpadDisplayCard(enteredNumber: enteredNumber),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 20,
                    child: Icon(
                      Icons.local_florist,
                      size: 100,
                      color: Colors.white.withOpacity(0.25),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 20,
                    child: Icon(
                      Icons.park,
                      size: 120,
                      color: Colors.white.withOpacity(0.25),
                    ),
                  ),
                ],
              ),
            ),
            DialpadKeypad(
              onKeyPressed: _onDialpadPressed,
              onHandleDragUp: () => _openHymnListSheet(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 6,
        shape: const CircleBorder(),
        onPressed: _openReader,
        child: const Icon(
          Icons.airline_seat_recline_normal,
          color: Colors.white,
          size: 28,
        ),
      ),
      bottomNavigationBar: HomeBottomBar(
        onCategoriesTap: () => _openHymnListSheet(),
        onFavoritesTap: () {},
      ),
    );
  }
}