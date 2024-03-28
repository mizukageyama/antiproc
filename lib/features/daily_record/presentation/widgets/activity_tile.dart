import 'dart:math';
import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget {
  ActivityTile({super.key});

  final _random = Random();
  double next(double max) => _random.nextDouble() * max;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.brunch_dining_rounded,
            size: 32.0,
            color: Colors.grey.shade400,
          ),
          const SizedBox(
            width: 30.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Brunch',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                LinearProgressIndicator(
                  value: next(1.0),
                  color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0),
                  backgroundColor: Colors.grey.shade200,
                  minHeight: 8.0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                Text(
                  'Lorem ipsum sit color amet.',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                const Text('7hr 31min'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
