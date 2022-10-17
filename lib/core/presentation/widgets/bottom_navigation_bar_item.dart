import 'package:flutter/material.dart';

class MyBottomNavigationBarItem extends BottomNavigationBarItem {
  final String location;

  const MyBottomNavigationBarItem({
    required super.label,
    required super.icon,
    required this.location,
  });
}
