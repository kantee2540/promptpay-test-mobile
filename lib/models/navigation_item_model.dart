import 'package:flutter/material.dart';

class NavigationItemModel {
  final String title;
  final String description;
  final Widget screen;

  NavigationItemModel({
    required this.title,
    required this.description,
    required this.screen,
  });
}
