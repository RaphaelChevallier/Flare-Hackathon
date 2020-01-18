import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;

class GetCurrentLocation extends StatefulWidget {
  @override
  _GetCurrentLocationState createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {
  Completer<GoogleMapController> _controller = Completer();
  static LatLng latLng;
  Iterable markers = [];

  @override
  void initState(){
    super.initState();
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
            });
            getData(latLng);
          }
        });
        break;
    }
  }

  getData(LatLng latLng) async {
    try {
      String latitude = latLng.latitude.toString();
      String longitude = latLng.longitude.toString();
      String APINearPlaces = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude  + ',' + longitude + '&radius=1500&type=restaurant,cafe,bus_station,atm,bank,lodging,local_government_office,store,subway_station,taxi_stand,food,&key=AIzaSyCSL00gc3nX5bkkUf1ckkkpL8pISNJOvWA';
      final response =
          await http.get(APINearPlaces);

      final int statusCode = response.statusCode;

      if (statusCode == 201 || statusCode == 200) {
        Map responseBody = json.decode(response.body);
        List results = responseBody["results"];

        Iterable _markers = Iterable.generate(20, (index) {
          Map result = results[index];
          globals.locations = result;
          Map location = result["geometry"]["location"];
          LatLng latLngMarker = LatLng(location["lat"], location["lng"]);

          return Marker(markerId: MarkerId("marker$index"),position: latLngMarker);
        });

        setState(() {
          markers = _markers;
        });
        print(globals.locations);
      } else {
        throw Exception('Error');
      }
    } catch(e) {
      print(e.toString());
    }
  }


  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle('[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      // markers: Set.from(
      //     markers,
      //   ),
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: latLng,
        zoom: 18.0,
        tilt: 50.0,
      ),
      indoorViewEnabled: true,
      myLocationEnabled: true,
    );
  }
}