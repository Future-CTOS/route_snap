import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({
    required this.options,
    this.children = const [],
    this.mapController,
    super.key,
  });

  final List<Widget> children;

  final MapOptions options;

  final MapController? mapController;

  @override
  Widget build(BuildContext context) => FlutterMap(
    options: options,
    mapController: mapController ?? MapController(),
    children: children,
  );
}

//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:geolocator/geolocator.dart';
//
// class StartPage extends StatefulWidget {
//   const StartPage({super.key});
//
//   @override
//   State<StartPage> createState() => _StartPageState();
// }
//
// class _StartPageState extends State<StartPage> {
//   LatLng _center = LatLng(35.6892, 51.3890);
//   LatLng? _start;
//   LatLng? _end;
//   LatLng? _myLocation;
//
//   final MapController _mapController = MapController();
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation(autoMove: true);
//   }
//
//   Future<void> _getCurrentLocation({bool autoMove = false}) async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) throw 'GPS خاموش است';
//
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) throw 'اجازه رد شد';
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         throw 'اجازه برای همیشه رد شده';
//       }
//
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       LatLng newCenter = LatLng(position.latitude, position.longitude);
//
//       setState(() {
//         _center = newCenter;
//         _myLocation = newCenter;
//       });
//
//       if (autoMove) {
//         _mapController.move(newCenter, 15.0);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('❌ خطا در دریافت لوکیشن: $e'),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: Colors.red,
//           margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }
//
//   void _handleTap(TapPosition tapPosition, LatLng point) {
//     setState(() {
//       if (_start == null) {
//         _start = point;
//       } else if (_end == null) {
//         _end = point;
//       } else {
//         _start = point;
//         _end = null;
//       }
//     });
//   }
//
//   double _calculateDistance() {
//     if (_start == null || _end == null) return 0.0;
//     final Distance distance = Distance();
//     return distance.as(LengthUnit.Kilometer, _start!, _end!);
//   }
//
//   void _submit() {
//     if (_start != null && _end != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('سفر با موفقیت ثبت شد'),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: Colors.green,
//           margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
//           duration: Duration(seconds: 2),
//         ),
//       );
//
//       Future.delayed(Duration(seconds: 1), () {
//         Navigator.pop(context, {
//           'start': _start,
//           'end': _end,
//           'distance': _calculateDistance(),
//         });
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('لطفاً مبدا و مقصد را انتخاب کنید'),
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: Colors.red,
//           margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }
//
//   void _useMyLocationAsStart() {
//     if (_myLocation != null) {
//       setState(() {
//         _start = _myLocation;
//       });
//     }
//   }
//
//   void _goToMyLocation() async {
//     await _getCurrentLocation();
//     if (_myLocation != null) {
//       _mapController.move(_myLocation!, 15);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) =>
//       Scaffold(appBar: AppBar(title: Text('انتخاب مسیر')), body: _body());
//
//   Widget _body() => Column(
//     children: [
//       _actions(),
//       if (_start != null && _end != null) _distance(),
//       Expanded(child: _map()),
//     ],
//   );
//
//   Widget _map() => FlutterMap(
//     mapController: _mapController,
//     options: MapOptions(
//       initialCenter: _center,
//       initialZoom: 14,
//       onTap: _handleTap,
//     ),
//     children: [
//       TileLayer(
//         urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//         subdomains: ['a', 'b', 'c'],
//       ),
//       MarkerLayer(
//         markers: [
//           if (_myLocation != null)
//             Marker(
//               point: _myLocation!,
//               width: 40,
//               height: 40,
//               child: Icon(Icons.my_location, color: Colors.blue, size: 30),
//             ),
//           if (_start != null)
//             Marker(
//               point: _start!,
//               width: 40,
//               height: 40,
//               child: Icon(Icons.location_on, color: Colors.green, size: 40),
//             ),
//           if (_end != null)
//             Marker(
//               point: _end!,
//               width: 40,
//               height: 40,
//               child: Icon(Icons.flag, color: Colors.red, size: 40),
//             ),
//         ],
//       ),
//       if (_start != null && _end != null)
//         PolylineLayer(
//           polylines: [
//             Polyline(
//               points: [_start!, _end!],
//               strokeWidth: 4,
//               color: Colors.purple,
//             ),
//           ],
//         ),
//     ],
//   );
//
//   Widget _distance() => Padding(
//     padding: const EdgeInsets.only(bottom: 8),
//     child: Text(
//       'فاصله: ${_calculateDistance().toStringAsFixed(2)} کیلومتر',
//       style: TextStyle(fontWeight: FontWeight.bold),
//     ),
//   );
//
//   Widget _actions() => Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//     child: SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           ElevatedButton.icon(
//             onPressed: _goToMyLocation,
//             icon: Icon(Icons.my_location),
//             label: Text("موقعیت من"),
//           ),
//           const SizedBox(width: 8),
//           ElevatedButton.icon(
//             onPressed: _myLocation != null ? _useMyLocationAsStart : null,
//             icon: Icon(Icons.gps_fixed),
//             label: Text("به‌عنوان مبدا"),
//           ),
//           const SizedBox(width: 8),
//           ElevatedButton.icon(
//             onPressed: (_start != null && _end != null) ? _submit : null,
//             icon: Icon(Icons.check),
//             label: Text("ثبت مسیر"),
//           ),
//         ],
//       ),
//     ),
//   );
// }