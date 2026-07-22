import 'package:flutter/material.dart';

class DialpadDisplayCard extends StatelessWidget {
  final String enteredNumber;

  const DialpadDisplayCard({
    super.key,
    required this.enteredNumber,
  });

  @override
  Widget build(BuildContext context) {
    final displayNum = enteredNumber.isEmpty ? '0' : enteredNumber;
    final intNum = int.tryParse(displayNum) ?? 0;

    Widget infoCard;
    if (intNum == 0) {
      infoCard = const Text(
        'A Devotion is available!\nswipe me to the right to open',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 15),
      );
    } else if (intNum > 225) {
      infoCard = const Text(
        'Valid Range is between (1-225)',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 15),
      );
    } else {
      infoCard = const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sabbath Day',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Sabiiti Erukwera',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(height: 2),
          Text('Doh:', style: TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Big Dialpad Number
        Text(
          displayNum,
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black26,
                offset: Offset(2, 4),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Preview Card
        Container(
          width: MediaQuery.of(context).size.width * 0.82,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: infoCard,
        ),
      ],
    );
  }
}