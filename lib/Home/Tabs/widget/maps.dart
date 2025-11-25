import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<Maps> {
  GoogleMapController? mapController;
  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  final LatLng _currentLatLng = const LatLng(30.033333, 31.233334);

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: const MarkerId('center'),
        position: _currentLatLng,
        infoWindow: const InfoWindow(title: 'Center'),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _goToCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    LocationData locationData = await location.getLocation();
    LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 16)),
    );

    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: latLng,
          infoWindow: const InfoWindow(title: 'My Location'),
        ),
      );
    });
  }

  void _changeMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : _currentMapType == MapType.satellite
          ? MapType.hybrid
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: _currentMapType,
            initialCameraPosition: CameraPosition(
              target: _currentLatLng,
              zoom: 13,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          Positioned(
            top: 40,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'locationBtn',
                  onPressed: _goToCurrentLocation,
                  mini: true,
                  child: const Icon(Icons.my_location),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'mapTypeBtn',
                  onPressed: _changeMapType,
                  mini: true,
                  child: const Icon(Icons.map),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
