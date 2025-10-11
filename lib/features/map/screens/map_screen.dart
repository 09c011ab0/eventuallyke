import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../events/providers/event_providers.dart';
import '../providers/location_providers.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionAsync = ref.watch(currentPositionProvider);
    final events = ref.watch(eventServiceProvider).getAll();

    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: positionAsync.when(
        data: (pos) {
          final markers = events
              .map(
                (e) => Marker(
                  markerId: MarkerId(e.id),
                  position: LatLng(e.latitude, e.longitude),
                  infoWindow: InfoWindow(title: e.title, snippet: e.city),
                ),
              )
              .toSet();

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(pos.latitude, pos.longitude),
              zoom: 11,
            ),
            myLocationEnabled: true,
            markers: markers,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(
          child: Text('Location unavailable: ${err.toString()}'),
        ),
      ),
    );
  }
}
