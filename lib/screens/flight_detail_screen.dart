import 'package:flutter/material.dart';
import '../models/flight.dart';

class FlightDetailScreen extends StatelessWidget {
  final Flight flight;
  const FlightDetailScreen({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(flight.callsign ?? 'Vol inconnu')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _row('Callsign', flight.callsign ?? '—'),
          _row('ICAO24', flight.icao24),
          _row('Pays d\'origine', flight.originCountry ?? '—'),
          _row('Latitude', flight.latitude?.toStringAsFixed(4) ?? '—'),
          _row('Longitude', flight.longitude?.toStringAsFixed(4) ?? '—'),
          _row('Altitude', '${flight.altitude?.toStringAsFixed(0) ?? '—'} m'),
          _row('Vitesse', '${flight.velocity?.toStringAsFixed(0) ?? '—'} m/s'),
          _row('Cap', '${flight.heading?.toStringAsFixed(0) ?? '—'}°'),
          _row('Au sol', flight.onGround ? 'Oui' : 'Non'),
        ],
      ),
    );
  }

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                k,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(v),
          ],
        ),
      );
}
