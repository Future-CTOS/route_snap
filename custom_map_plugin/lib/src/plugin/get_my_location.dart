import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class GetMyLocation extends StatefulWidget {
  const GetMyLocation({super.key});

  @override
  State<GetMyLocation> createState() => _GetMyLocationState();
}

class _GetMyLocationState extends State<GetMyLocation> {
  Position? position;

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    try {
      final pos = await _determinePosition();
      setState(() => position = pos);
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (position == null) {
      return const SizedBox();
    }

    return MarkerLayer(
      markers: [
        Marker(
          width: 20,
          height: 20,
          point: LatLng(position!.latitude, position!.longitude),
          child: const Icon(Icons.location_on_sharp),
        ),
      ],
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }
}
