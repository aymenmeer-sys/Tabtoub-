import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/flight.dart';

class OpenSkyService {
  static const String _base = 'https://opensky-network.org/api';

  /// Récupère tous les vols dans une zone (bounding box).
  Future<List<Flight>> getFlights({
    double? lamin,
    double? lomin,
    double? lamax,
    double? lomax,
  }) async {
    final params = <String, String>{};
    if (lamin != null) params['lamin'] = lamin.toString();
    if (lomin != null) params['lomin'] = lomin.toString();
    if (lamax != null) params['lamax'] = lamax.toString();
    if (lomax != null) params['lomax'] = lomax.toString();

    final uri = Uri.parse('$_base/states/all')
        .replace(queryParameters: params.isEmpty ? null : params);

    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 20));
      if (res.statusCode != 200) return [];
      final data = jsonDecode(res.body);
      final states = data['states'] as List<dynamic>? ?? [];
      return states
          .map((s) => Flight.fromOpenSky(s as List<dynamic>))
          .where((f) => f.hasPosition)
          .toList();
    } catch (_) {
      return [];
    }
  }
}
