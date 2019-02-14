import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simple_permissions/simple_permissions.dart';

class MapsDemo extends StatefulWidget {
  @override
  State createState() => MapsDemoState();
}

class MapsDemoState extends State<MapsDemo> {
  GoogleMapController mapController;
  String _platformVersion = 'Unknown';
  Permission permission;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  requestPermission() async {
    return await SimplePermissions.requestPermission(
        Permission.AccessCoarseLocation);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await SimplePermissions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: SizedBox(
          width: mq.size.width,
          height: mq.size.height,
          child: Center(
              child: GoogleMap(
            onMapCreated: _onMapCreated,
            options: GoogleMapOptions(
                myLocationEnabled: true,
                cameraPosition: const CameraPosition(target: LatLng(0.0, 0.0))),
          )),
        ),
      ),
      /*RaisedButton(
                child: const Text('Go to London'),
                onPressed: mapController == null
                    ? null
                    : () {
                        mapController
                            .animateCamera(CameraUpdate.newCameraPosition(
                          const CameraPosition(
                            bearing: 270.0,
                            target: LatLng(51.5160895, -0.1294527),
                            tilt: 30.0,
                            zoom: 17.0,
                          ),
                        ));
                      },
              ),*/
    );
  }

  getLocation() async {
    return await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      Position position;

      if (requestPermission() == PermissionStatus.authorized) {
        setState(() {
          print("permission request result is " +
              PermissionStatus.authorized.toString());
          position = getLocation();

          mapController.addMarker(MarkerOptions(
              zIndex: 1.toDouble(),
              position: LatLng(
                  position.latitude.toDouble(), position.longitude.toDouble()),
              infoWindowText: InfoWindowText("Your place", "you are here")));

          mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  //bearing: 270.0,
                  //target: LatLng(-33.856159, 151.215256),
                  target: LatLng(position.latitude.toDouble(),
                      position.longitude.toDouble()),
                  //tilt: 30.0,
                  zoom: 20.0)));
        });
      }
    });
  }
}
