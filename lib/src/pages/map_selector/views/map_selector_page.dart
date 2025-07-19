import 'package:flutter/material.dart';
import 'package:custom_map_plugin/custom_map_export.dart';
import 'package:get/get.dart';

import '../../../infrastructure/common/repository_urls.dart';
import '../../../infrastructure/utils/utils.dart';
import '../controller/map_selector_controller.dart';

class MapSelectorPage extends GetView<MapSelectorController> {
  const MapSelectorPage({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: _appBar(),
    body: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(Utils.largeSpace)),
      child: Stack(
        children: [_map(context), _topOverlayInfo(), _requestButton()],
      ),
    ),
  );

  PreferredSizeWidget _appBar() => AppBar(
    title: const Text('انتخاب مبدا و مقصد'),
    actions: [
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () => controller.resetSelection(),
      ),
    ],
  );

  Widget _map(BuildContext context) => Obx(
    () => CustomMap(
      mapController: controller.mapController,
      options: MapOptions(onTap: controller.onMapTap),
      children: _children(context),
    ),
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

  Widget _zoomPlugin(final BuildContext context) => Positioned(
    bottom: 150,
    right: 10,
    child: ZoomButton(mapController: controller.mapController),
  );

  List<Widget> _children(BuildContext context) => [
    CustomTileLayer(
      urlTemplate: RepositoryUrls.openStreetUrl,
      subdomains: const ['a', 'b', 'c'],
    ),
    _markers(),
    _polyLine(),
    _markerPlugin(),
    _myLocationPlugin(),
    _zoomPlugin(context),
  ];

  Widget _markers() {
    final markers = <Marker>[];

    if (controller.startPoint.value != null) {
      markers.add(
        Marker(
          width: 40,
          height: 40,
          point: controller.startPoint.value!,
          child: const Icon(Icons.location_on_sharp, color: Colors.limeAccent),
        ),
      );
    }

    if (controller.endPoint.value != null) {
      markers.add(
        Marker(
          width: 40,
          height: 40,
          point: controller.endPoint.value!,
          child: const Icon(Icons.location_on_sharp, color: Colors.purple),
        ),
      );
    }

    return MarkerLayer(markers: markers);
  }

  Widget _polyLine() {
    if (controller.startPoint.value == null ||
        controller.endPoint.value == null) {
      return SizedBox.shrink();
    }
    return PolylineLayer(
      polylines: [
        Polyline(
          points: [controller.startPoint.value!, controller.endPoint.value!],
          strokeWidth: 8,
          color: Colors.tealAccent,
        ),
      ],
    );
  }

  Widget _topOverlayInfo() => Positioned(
    top: 10,
    left: 10,
    right: 10,
    child: Obx(() {
      final distance = controller.distance.value;
      if (distance == 0) return const SizedBox.shrink();
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Text('فاصله${distance.toStringAsFixed(5)}'),
      );
    }),
  );

  Widget _requestButton() => Positioned(
    bottom: 20,
    left: 20,
    right: 20,
    child: Obx(() {
      if (controller.startPoint.value != null &&
          controller.endPoint.value != null) {
        return ElevatedButton(
          onPressed:
              () => Get.defaultDialog(
                title: 'درخواست ثبت شد',
                middleText: 'سفر با موفقیت ثبت شد.',
                confirm: ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('باشه'),
                ),
              ),
          child: const Text('درخواست سفر'),
        );
      }
      return const SizedBox.shrink();
    }),
  );
}
