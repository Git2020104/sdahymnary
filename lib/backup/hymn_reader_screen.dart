import 'package:flutter/material.dart';

class HymnReaderScreen extends StatefulWidget {
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
  State<HymnReaderScreen> createState() => _HymnReaderScreenState();
}

class _HymnReaderScreenState extends State<HymnReaderScreen> {
  void _showCommentsSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comments on song: ${widget.number}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Divider(height: 24),
            const Text(
              'Summary',
              style: TextStyle(
                color: Color(0xFF1E7BB5),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Content not available!',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Scripture',
              style: TextStyle(
                color: Color(0xFF1E7BB5),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Mark 2:27\n"The Sabbath was made for the good of human beings; they were not made for the Sabbath."',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1E7BB5);
    final songTitle = widget.title ?? 'Sabiiti Erukwera - Sabbath Day';
    final keyNotation = widget.keySig ?? 'Doh:';

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Song no.${widget.number} - $songTitle',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      body: Stack(
        children: [
          // Content Container
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 90),
              children: [
                Text(
                  'Sabiiti Erukwera',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Sabbath Day',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                Text(
                  keyNotation,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const Divider(height: 28, thickness: 1),

                _buildVerse(
                  '1',
                  'Sabiiti erukwera, (E)kampebwa\ny\'omuhendo; Ija, Ija garuka,\nTuhumule itwena.',
                ),
                _buildVerse(
                  '2',
                  '(O)mulimo (o)bugulihwa, Tuserrege\nRuhanga; Ha meeza ya Isiitwe,\nTuhurre ebigambo.',
                ),
                _buildVerse(
                  '3',
                  'Ntukulinda Ai Yesu, Tuh(e) emigisa\nnyingi; Ikiriza enjiri, Ikar(a) omu nda\nzaitu.',
                ),
                _buildVerse(
                  '4',
                  '(E)kigambo kyawe hati, Kisingul(e)\nemituma; Tuliise, Ai Yesu,\nEby\'okulya by\'omwoyo.',
                ),
                _buildVerse(
                  '5',
                  'Mukama akasumi, Nikaija\ntukonyare; Ha Sabbath(i) etahwaho,',
                ),
              ],
            ),
          ),

          // Floating Tool Buttons on Right side
          Positioned(
            right: 16,
            top: 48,
            child: Column(
              children: [
                _buildSideButton('Aa', isText: true),
                const SizedBox(height: 10),
                _buildSideButton('', icon: Icons.share_outlined),
                const SizedBox(height: 10),
                _buildSideButton(
                  '',
                  icon: Icons.thumb_up_alt_outlined,
                  color: Colors.orange,
                ),
                const SizedBox(height: 10),
                _buildSideButton('ENG', isText: true),
              ],
            ),
          ),
        ],
      ),

      // Audio Play Floating Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 6,
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.play_arrow, color: Colors.white, size: 34),
      ),

      // Reader Bottom Action Bar
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
              onPressed: _showCommentsSheet,
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.dialpad, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerse(String verseNum, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '[ Verse $verseNum ]',
            style: const TextStyle(
              color: Color(0xFF1E7BB5),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade800,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideButton(
      String text, {
        IconData? icon,
        Color color = const Color(0xFF1E7BB5),
        bool isText = false,
      }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: isText
            ? Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        )
            : Icon(icon, color: color, size: 18),
      ),
    );
  }
}
