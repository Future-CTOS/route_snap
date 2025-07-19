import 'package:get/get.dart';
import 'package:custom_map_plugin/custom_map_export.dart';
import '../../../infrastructure/utils/utils.dart';

class MapSelectorController extends GetxController {
  final MapController mapController = MapController();
  final Rxn<LatLng> startPoint = Rxn();
  final Rxn<LatLng> endPoint = Rxn();

  final Rx<LatLng> mapCenterPosition = Utils.defaultLocation.obs;
  final RxDouble distance = 0.0.obs;

  void onMapTap(TapPosition tapPosition, LatLng point) {
    if (startPoint.value == null) {
      startPoint.value = point;
    } else if (endPoint.value == null) {
      endPoint.value = point;
      distance.value = _calculateDistance();
    } else {
      startPoint.value = point;
      endPoint.value = null;
      distance.value = 0.0;
    }
  }

  double _calculateDistance() {
    if (startPoint.value == null || endPoint.value == null) return 0.0;
    final Distance distanceCalculator = const Distance();
    return distanceCalculator.as(
      LengthUnit.Kilometer,
      startPoint.value!,
      endPoint.value!,
    );
  }

  void resetSelection() {
    startPoint.value = null;
    endPoint.value = null;
    distance.value = 0.0;
  }
}
