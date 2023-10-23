import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsDemo extends StatefulWidget {
  const GoogleMapsDemo({Key? key}) : super(key: key);

  @override
  State<GoogleMapsDemo> createState() => _GoogleMapsDemoState();
}

class _GoogleMapsDemoState extends State<GoogleMapsDemo> {
  late GoogleMapController _controller;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Set<Marker> markerList = {
    const Marker(
      markerId: MarkerId("01"),
      position: LatLng(21.237106539704083, 72.87721937617128),
    )
  };

  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Scaffold(
       appBar: AppBar(
         title:  const Text("Google Map"),
       ),
       body:  GoogleMap(
          mapType: MapType.satellite,
          initialCameraPosition: _kGooglePlex,
          onTap: (v) {
            debugPrint("v  $v");
            markerList.add(Marker(
                markerId: MarkerId("${DateTime.now().millisecondsSinceEpoch}"),
                position: v,
                onTap: () {
                  debugPrint("Hello i am flutter dev");
                }));
            _controller.animateCamera(CameraUpdate.newLatLngZoom(v, 15));
            setState(() {});
          },
          markers: markerList,
          polygons: {
            Polygon(
                polygonId: const PolygonId("45"),
                points: const [
                  LatLng(21.2393459037548, 72.85018976341622),
                  LatLng(21.24547197173319, 72.85800893205995),
                  LatLng(21.241983219801828, 72.86735005113866),
                  LatLng(21.231847819604912, 72.86624763469435),
                ],
                fillColor: Colors.pink.withOpacity(0.4),
                strokeColor: Colors.yellow)
          },
          polylines: {
            const Polyline(
                polylineId: PolylineId("22"),
                color: Colors.blue,
                width: 3,
                points: [
                  LatLng(21.231588343104864, 72.86625858749811),
                  LatLng(21.217333740805742, 72.86641828715801),
                ])
          },
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
        ),
     ),
   );
  }
}
