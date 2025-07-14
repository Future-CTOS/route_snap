import 'package:flutter_map/flutter_map.dart';

class CustomTileLayer extends TileLayer {
  CustomTileLayer({
    required super.urlTemplate,
    required super.subdomains,
    super.key,
  });
}
