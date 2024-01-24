import 'dart:ui';

import 'package:flutter/material.dart';

class ReqCall {
  final String address;
  final String state;
  final Color color;
  final String imagePath;
  // final Navigator ontab;
  final VoidCallback ontab;

  ReqCall({
    required this.address,
    required this.color,
    required this.imagePath,
    required this.state,
    required this.ontab,
  });
}
