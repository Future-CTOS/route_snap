import 'package:flutter/material.dart';
import 'package:custom_map_plugin/custom_map_export.dart';
import 'package:get/get.dart';

import '../../../infrastructure/common/repository_urls.dart';
import '../../../infrastructure/utils/utils.dart';
import '../controller/map_selector_controller.dart';

class MapSelectorPage extends GetView<MapSelectorController> {
  const MapSelectorPage({super.key});

  @override
  Widget build(final BuildContext context) => ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(Utils.largeSpace)),
    child: _map(context),
  );

  Widget _map(BuildContext context) => CustomMap(
    mapController: controller.mapController,
    options: CustomMapOptions(),
    children: _children(context),
  );

  Widget _markerPlugin() => MarkerLayer(
    markers: [
      Marker(
        point: controller.mapCenterPosition.value,
        child: Icon(Icons.location_on_rounded),
      ),
    ],
  );

  Widget _myLocationPlugin() => ElevatedButton(
    onPressed:
        () => controller.mapController.move(
          controller.mapCenterPosition.value,
          controller.mapController.camera.zoom,
        ),
    child: const Icon(Icons.location_searching),
  );

  Widget _zoomPlugin(final BuildContext context) =>
      ZoomButton(mapController: controller.mapController);

  List<Widget> _children(BuildContext context) => [
    CustomTileLayer(
      urlTemplate: RepositoryUrls.openStreetUrl,
      subdomains: const ['a', 'b', 'c'],
    ),
    _markerPlugin(),
    _myLocationPlugin(),
    _zoomPlugin(context),
  ];
}
