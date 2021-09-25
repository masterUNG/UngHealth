import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMap extends StatelessWidget {
  final LatLng latlng;
  const ShowMap({Key? key, required this.latlng}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: latlng,
        zoom: 14,
      ),
      onMapCreated: (controller) {},
      markers: <Marker>[
        Marker(
          markerId: MarkerId('id'),
          position: latlng,
          infoWindow: InfoWindow(title: 'You Here ?', snippet: 'lat = ${latlng.latitude}, lng = ${latlng.longitude}'),
        ),
      ].toSet(),
    );
  }
}
