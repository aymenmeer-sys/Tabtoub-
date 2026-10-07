import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/flight.dart';
import '../services/opensky_service.dart';
import '../widgets/flight_marker.dart';
import 'flight_detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _service = OpenSkyService();
  List<Flight> _flights = [];
  Timer? _timer;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) => _load());
  }

  Future<void> _load() async {
    final data = await _service.getFlights(
      lamin: 20, lomin: -20, lamax: 60, lomax: 40,
    );
    if (!mounted) return;
    setState(() {
      _flights = data;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabtoub Fly'),
        actions: [
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(35.0, 10.0),
          initialZoom: 5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.tabtoub.fly',
          ),
          MarkerLayer(
            markers: _flights
                .map((f) => Marker(
                      point: LatLng(f.latitude!, f.longitude!),
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FlightDetailScreen(flight: f),
                          ),
                        ),
                        child: FlightMarker(heading: f.heading ?? 0),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _load,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
