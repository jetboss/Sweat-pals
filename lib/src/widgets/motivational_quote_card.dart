import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/constants.dart';

class MotivationalQuoteCard extends StatefulWidget {
  const MotivationalQuoteCard({super.key});

  @override
  State<MotivationalQuoteCard> createState() => _MotivationalQuoteCardState();
}

class _MotivationalQuoteCardState extends State<MotivationalQuoteCard> {
  late String _quote;

  @override
  void initState() {
    super.initState();
    _quote = AppConstants.motivationalQuotes[Random().nextInt(AppConstants.motivationalQuotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink[50]!, Colors.pink[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(Icons.favorite_rounded, color: Colors.pink, size: 32),
          const SizedBox(height: 16),
          Text(
            _quote,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'We got this!',
            style: TextStyle(color: Colors.pinkAccent),
          ),
        ],
      ),
    );
  }
}
