import 'package:flutter/material.dart';

class StatItem {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;
  final Duration delay;

  const StatItem({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
    required this.delay,
  });
}
