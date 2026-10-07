class Flight {
  final String icao24;
  final String? callsign;
  final String? originCountry;
  final double? longitude;
  final double? latitude;
  final double? altitude;
  final double? velocity;
  final double? heading;
  final bool onGround;

  Flight({
    required this.icao24,
    this.callsign,
    this.originCountry,
    this.longitude,
    this.latitude,
    this.altitude,
    this.velocity,
    this.heading,
    this.onGround = false,
  });

  factory Flight.fromOpenSky(List<dynamic> state) {
    return Flight(
      icao24: state[0] ?? '',
      callsign: (state[1] as String?)?.trim(),
      originCountry: state[2],
      longitude: (state[5] as num?)?.toDouble(),
      latitude: (state[6] as num?)?.toDouble(),
      altitude: (state[7] as num?)?.toDouble(),
      onGround: state[8] ?? false,
      velocity: (state[9] as num?)?.toDouble(),
      heading: (state[10] as num?)?.toDouble(),
    );
  }

  bool get hasPosition => latitude != null && longitude != null;
}
