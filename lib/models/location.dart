import 'dart:ui';

class Location {
  final String address;
  final String state;
  final Color color;
  final String imagePath;
  final Function() tabRoute;
  Location({
    required this.address,
    required this.color,
    required this.imagePath,
    required this.state,
    required this.tabRoute,
  });
}
