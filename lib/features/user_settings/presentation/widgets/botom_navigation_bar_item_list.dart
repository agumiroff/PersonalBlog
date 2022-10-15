import 'package:flutter/material.dart';
import 'bottom_navigation_bar_item.dart';

const navigationBarItems = [
  MyBottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
    location: '/home',
  ),
  MyBottomNavigationBarItem(
    label: 'Search',
    icon: Icon(Icons.search),
    location: '/search',
  ),
  MyBottomNavigationBarItem(
    label: 'Add post',
    icon: Icon(Icons.add_box_outlined),
    location: '/add_post',
  ),
  MyBottomNavigationBarItem(
    label: 'Profile',
    icon: Icon(Icons.settings),
    location: '/profile_settings',
  ),
];
