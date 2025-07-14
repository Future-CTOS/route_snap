import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
class ZoomButton extends StatefulWidget {
  const ZoomButton({
    this.minZoom = 1,
    this.maxZoom = 28,
    this.padding = 2.0,
    required this.mapController,
    super.key,
  });

  final int minZoom;
  final int maxZoom;
  final double padding;
  final MapController mapController;

  @override
  State<ZoomButton> createState() => _ZoomButtonState();
}

class _ZoomButtonState extends State<ZoomButton> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.bottomRight,
    child: Column(
      children: [
        _zoomButton(onTap: _onZoomInTap, icon: Icons.add),
        SizedBox(height: 4),
        _zoomButton(onTap: _onZoomOutTap, icon: Icons.minimize),
      ],
    ),
  );

  Widget _zoomButton({required VoidCallback onTap, required IconData icon}) =>
      IconButton(
          color: Colors.red,
          icon: Icon(icon), onPressed: onTap);

  void _onZoomOutTap() {
    final mapState = widget.mapController.camera;
    final double zoom = mapState.zoom - 1;
    if (zoom > widget.minZoom) {
      widget.mapController.move(mapState.center, zoom);
    }
  }

  void _onZoomInTap() {
    final mapState = widget.mapController.camera;
    final double zoom = mapState.zoom + 1;
    if (zoom < widget.maxZoom) {
      widget.mapController.move(mapState.center, zoom);
    }
  }
}
