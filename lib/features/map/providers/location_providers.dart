import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final locationPermissionProvider = FutureProvider<LocationPermission>((ref) async {
  return Geolocator.checkPermission();
});

final currentPositionProvider = FutureProvider<Position>((ref) async {
  final permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    final newPerm = await Geolocator.requestPermission();
    if (newPerm == LocationPermission.denied || newPerm == LocationPermission.deniedForever) {
      throw Exception('Location permission denied');
    }
  }
  return Geolocator.getCurrentPosition();
});
