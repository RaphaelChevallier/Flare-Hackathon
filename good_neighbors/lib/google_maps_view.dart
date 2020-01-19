import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'accept_flare.dart';
class GetCurrentLocation extends StatefulWidget {
  @override
  _GetCurrentLocationState createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {

  Completer<GoogleMapController> _controller = Completer();
  List keys = [];
  static LatLng latLng;
  // Iterable markers = [];
  Set<Marker> markers = Set();

  @override
  void initState(){
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child("requests").once().then((DataSnapshot snap){
    for(var key in snap.value.keys){
      if(snap.value[key]['resolved'] == false){
        print(snap.value[key]);
        Marker resultMarker = Marker(
        markerId: MarkerId(key),
        infoWindow: InfoWindow(
        onTap: () { Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AcceptFlare(snap.value[key], key.toString()),
        ),
        );
        },
        title: "${snap.value[key]['category']}",
        snippet: "${snap.value[key]['description']}"),
        position: LatLng(snap.value[key]['latitude'],
        snap.value[key]['longitude']),
        );
        // Add it to Set
        markers.add(resultMarker);
      }
    }
    setState(() {
      this.markers = markers;
    }); 
    });
    getLocation();
  }

   Future<void> getLocation() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    var geolocator = Geolocator();
    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();
    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        print('denied');
        break;
      case GeolocationStatus.disabled:
      case GeolocationStatus.restricted:
        print('restricted');
        break;
      case GeolocationStatus.unknown:
        print('unknown');
        break;
      case GeolocationStatus.granted:
        await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            .then((Position _position) {
          if (_position != null) {
            setState((){
              latLng = LatLng(_position.latitude, _position.longitude,);
              globals.Lat = _position.latitude;
              globals.Long = _position.longitude;
            });
          }
        });
        break;
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle('[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
  }

  @override
  Widget build(BuildContext context) {
      return GoogleMap(
      markers: markers,
      // markers: Set.from(
      //     markers,
      //   ),
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: latLng,
        zoom: 13.0,
        tilt: 15.0,
      ),
      indoorViewEnabled: true,
      myLocationEnabled: true,
    );
  }

}