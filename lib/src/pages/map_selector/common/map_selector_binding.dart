import 'package:get/get.dart';

import '../controller/map_selector_controller.dart';

class MapSelectorBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => MapSelectorController());
}
