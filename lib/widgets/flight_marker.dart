import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlightMarker extends StatelessWidget {
  final double heading;
  const FlightMarker({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: heading * math.pi / 180,
      child: const Icon(Icons.flight, color: Color(0xFFFF7A00), size: 28),
    );
  }
}
