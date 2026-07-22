import 'package:flutter/material.dart';
import '../../../song/presentation/hymn_reader_screen.dart';

class HymnListSheet extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const HymnListSheet({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  static final List<Map<String, String>> sampleHymns = [
    {'number': '1', 'title': "Gw'oli Mutukuvi", 'key': 'Doh is E'},
    {'number': '2', 'title': 'Ka Tukusuute', 'key': 'Doh is G'},
    {'number': '3', 'title': 'Aweebwe Ekitiibwa', 'key': 'Doh is Ab'},
    {'number': '4', 'title': 'Tusinza Nnyo Erinnya Lye', 'key': 'Doh is G'},
    {'number': '56', 'title': 'Sabiiti Erukwera', 'key': 'Doh is F'},
    {'number': '102', 'title': 'Ruhanga Niwe Muco', 'key': 'Doh is Bb'},
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1E7BB5);

    final filtered = sampleHymns.where((hymn) {
      final q = searchQuery.toLowerCase();
      final title = hymn['title']!.toLowerCase();
      final num = hymn['number']!;
      return title.contains(q) || num.contains(q);
    }).toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.80,
      minChildSize: 0.35,
      maxChildSize: 0.88, // Keeps top margin so screen isn't completely covered
      builder: (context, scrollController) {
        return Padding(
          // Outer margins (Left, Right, Bottom) so it floats off screen edges
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF4F5F7), // Signal White canvas
              borderRadius: BorderRadius.circular(24), // Fully rounded card
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.22),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                children: [
                  // Handle Pill Indicator
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 6),
                    width: 38,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Search Field inside Sheet
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    child: SizedBox(
                      height: 44,
                      child: TextField(
                        controller: TextEditingController(text: searchQuery)
                          ..selection = TextSelection.fromPosition(
                            TextPosition(offset: searchQuery.length),
                          ),
                        onChanged: onSearchChanged,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Search title or number...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: primaryColor,
                            size: 20,
                          ),
                          suffixIcon: searchQuery.isNotEmpty
                              ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.grey,
                              size: 18,
                            ),
                            onPressed: () => onSearchChanged(''),
                          )
                              : null,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Filtered Hymn List View
                  Expanded(
                    child: filtered.isEmpty
                        ? const Center(
                      child: Text(
                        'No hymns match your search',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    )
                        : ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(14, 6, 14, 20),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final hymn = filtered[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          elevation: 0.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 2,
                            ),
                            leading: Container(
                              width: 40,
                              height: 40,
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
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            title: Text(
                              hymn['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              'Key: ${hymn['key']}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: 20,
                            ),
                            onTap: () {
                              Navigator.pop(context);
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
            ),
          ),
        );
      },
    );
  }
}