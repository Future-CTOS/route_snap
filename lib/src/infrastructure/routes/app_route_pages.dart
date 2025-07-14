import 'package:get/get.dart';
import 'package:route_snap/src/pages/map_selector/common/map_selector_binding.dart';

import '../../pages/map_selector/controller/map_selector_controller.dart';
import '../../pages/map_selector/views/map_selector_page.dart';
import '../../pages/splash/common/splash_binding.dart';
import '../../pages/splash/controllers/splash_controller.dart';
import '../../pages/splash/views/splash_screen.dart';
import 'route_paths.dart';

class AppRoutePages {
  const AppRoutePages._();

  static final List<GetPage> routes = [_splash, _mapSelector];

  static GetPage<MapSelectorController> get _mapSelector => GetPage(
    name: RoutePaths.mapSelector,
    page: MapSelectorPage.new,
    binding: MapSelectorBinding(),
  );

  static GetPage<SplashController> get _splash => GetPage(
    name: RoutePaths.splash,
    page: SplashScreen.new,
    binding: SplashBinding(),
  );
}
