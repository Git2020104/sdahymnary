import 'package:flutter/material.dart';
import 'package:flutter_midi_pro/flutter_midi_pro.dart';

class MidiPlayerWidget extends StatefulWidget {
  final String midiPath; // e.g. 'assets/midi/006.mid'
  final String soundFontPath; // e.g. 'assets/soundfonts/Piano.sf2'

  const MidiPlayerWidget({
    super.key,
    required this.midiPath,
    this.soundFontPath = 'assets/soundfonts/Piano2.sf2',
  });

  @override
  State<MidiPlayerWidget> createState() => _MidiPlayerWidgetState();
}

class _MidiPlayerWidgetState extends State<MidiPlayerWidget> {
  final MidiPro _midiPro = MidiPro();
  bool _isEngineReady = false;
  bool _isPlaying = false;
  int? _soundFontId;

  @override
  void initState() {
    super.initState();
    _loadSoundFont();
  }

  /// Loads the SoundFont (.sf2) file into memory
  Future<void> _loadSoundFont() async {
    try {
      final sfId = await _midiPro.loadSoundfont(sf2Path: widget.soundFontPath);
      if (mounted) {
        setState(() {
          _soundFontId = sfId;
          _isEngineReady = true;
        });
      }
    } catch (e) {
      debugPrint('Error loading SoundFont: $e');
    }
  }

  /// Plays the target MIDI asset file
  Future<void> _playMidi() async {
    if (!_isEngineReady || _soundFontId == null) return;

    try {
      await _midiPro.playMidi(midiPath: widget.midiPath, sf2Id: _soundFontId!);
      setState(() => _isPlaying = true);
    } catch (e) {
      debugPrint('Error playing MIDI file: $e');
    }
  }

  /// Stops current MIDI playback
  Future<void> _stopMidi() async {
    try {
      await _midiPro.stopMidi();
      if (mounted) {
        setState(() => _isPlaying = false);
      }
    } catch (e) {
      debugPrint('Error stopping MIDI playback: $e');
    }
  }

  @override
  void dispose() {
    _stopMidi();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isEngineReady) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 12),
            Text(
              'Loading Instrument SoundFont...',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
              size: 36,
            ),
            color: Theme.of(context).primaryColor,
            onPressed: _isPlaying ? _stopMidi : _playMidi,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isPlaying ? 'Playing Hymn Tune' : 'Play Hymn Tune',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                widget.midiPath.split('/').last,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
