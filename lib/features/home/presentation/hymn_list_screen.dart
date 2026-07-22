import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../song/presentation/hymn_reader_screen.dart';

class HymnListScreen extends StatefulWidget {
  const HymnListScreen({super.key});

  @override
  State<HymnListScreen> createState() => _HymnListScreenState();
}

class _HymnListScreenState extends State<HymnListScreen> {
  String selectedHymnal = 'Luganda';
  String searchQuery = '';

  // Mock list (will be replaced by SQLite queries)
  final List<Map<String, String>> sampleHymns = [
    {'number': '1', 'title': "Gw'oli Mutukuvi", 'key': 'Doh is E'},
    {'number': '2', 'title': 'Ka Tukusuute', 'key': 'Doh is G'},
    {'number': '3', 'title': 'Aweebwe Ekitiibwa', 'key': 'Doh is Ab'},
    {'number': '4', 'title': 'Tusinza Nnyo Erinnya Lye', 'key': 'Doh is G'},
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1E7BB5);

    // FIX: Filter hymns dynamically based on searchQuery
    final filteredHymns = sampleHymns.where((hymn) {
      final query = searchQuery.toLowerCase();
      final title = hymn['title']!.toLowerCase();
      final number = hymn['number']!;
      return title.contains(query) || number.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      drawer: const AppDrawer(), // Added AppDrawer
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text(
          'Multi-Hymnal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          // Styled Hymnal Selector Pill
          Container(
            margin: const EdgeInsets.only(right: 12, top: 10, bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedHymnal,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                dropdownColor: primaryColor,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                items: ['Luganda', 'English', 'Runyankore']
                    .map(
                      (hymnal) => DropdownMenuItem(
                    value: hymnal,
                    child: Text(hymnal),
                  ),
                )
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => selectedHymnal = val);
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search title or number...',
                prefixIcon: const Icon(Icons.search, color: primaryColor),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              onChanged: (val) => setState(() => searchQuery = val),
            ),
          ),

          // Filtered Hymn List
          Expanded(
            child: filteredHymns.isEmpty
                ? const Center(
              child: Text(
                'No hymns found',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredHymns.length,
              itemBuilder: (context, index) {
                final hymn = filteredHymns[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        hymn['number']!,
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    title: Text(
                      hymn['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text('Key: ${hymn['key']} • $selectedHymnal'),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      // FIX: Navigates to HymnReaderScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HymnReaderScreen(
                            number: hymn['number']!,
                            title: hymn['title']!,
                            keySig: hymn['key']!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}