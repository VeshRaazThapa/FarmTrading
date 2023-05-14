import 'package:agro_millets/colors.dart';
import 'package:agro_millets/core/map/application/map_manager.dart';
import 'package:agro_millets/core/map/application/map_provider.dart';
import 'package:agro_millets/core/home/application/home_manager.dart';
import 'package:agro_millets/core/home/presentation/widgets/agro_item.dart';
import 'package:agro_millets/globals.dart';
import 'package:agro_millets/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/user.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  late MapManager mapManager;
  MapController mapController = MapController();
  List<LatLng> farmerCoordinates = [];

  @override
  void initState() {
    mapManager = MapManager(context, ref);
    super.initState();
  }

  @override
  void dispose() {
    mapManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> buildMarkers() {
      List<User> map = ref.watch(mapProvider).getMap();

      if (map.isEmpty) {
        return [Marker(point:LatLng(27.694549317783395, 85.32055500746131),builder: (BuildContext context) {
          return Icon(Icons.location_on, color: Colors.red);
        },)];
      }

      return map.map((User user) {
          return Marker(
            point: LatLng(user.latitude,user.longitude),
            builder: (ctx) => GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(user.name),
                    content: Text(user.userType + "\n" + user.phone,style: const TextStyle(fontSize: 16),),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Icon(Icons.location_on, color: Colors.red),
            ),
            // builder: (BuildContext context) {
            //   return Icon(Icons.location_on, color: Colors.red);
            // },

          );
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Map"),
      ),
      body: SizedBox(
        // height: 200, // Set the desired height for the map
        // width: 500, // Set the width to match the parent widget or provide a fixed width
        child: Stack(
          children: [
            FlutterMap(
              mapController: mapController,

              options: MapOptions(
                center: LatLng(27.794549317783395, 85.62055500746131),
                zoom: 9,
                minZoom: 2, // Set the minimum zoom level
                maxZoom: 18,
                // onTap: (mapController,LatLng latLng) {
                //   setState(() {
                //     farmerCoordinates.add(latLng);
                //   });
                // },
                // Set the maximum zoom level
              ),

              children: [
                TileLayer(
                  urlTemplate: 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoidmVzaGciLCJhIjoiY2xobHo4OXlpMTcwMDNzcGhzZ2wxZmtzZSJ9.fV25khQviUGZ14rLQC__tw',
                  userAgentPackageName: 'com.example.agro_millets',
                ),

                MarkerLayer(
                  markers: buildMarkers(),
                ),

              ],

            ),
            Positioned(
              top: 10,
              right: 10,
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      mapController.move(mapController.center,18);
                    },
                    child: Icon(Icons.add),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: () {
                      mapController.move(mapController.center,8);
                    },
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
