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
