

import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
final String title;
final String value;
final IconData icon;
final Color color;

const StatCard({
super.key,
required this.title,
required this.value,
required this.icon,
this.color = Colors.blue,
});

@override
Widget build(BuildContext context) {
return Card(
elevation: 4,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16),
),
child: Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(16),
),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
CircleAvatar(
radius: 28,
backgroundColor: color.withOpacity(0.15),
child: Icon(
icon,
color: color,
size: 30,
),
),


        const SizedBox(height: 12),

        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    ),
  ),
);
}
}
