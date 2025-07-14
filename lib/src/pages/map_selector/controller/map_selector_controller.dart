import 'package:get/get.dart';
import 'package:custom_map_plugin/custom_map_export.dart';
import '../../../infrastructure/utils/utils.dart';

class MapSelectorController extends GetxController {
  final MapController mapController = MapController();

  final Rx<LatLng> mapCenterPosition = Utils.defaultLocation.obs;
}
