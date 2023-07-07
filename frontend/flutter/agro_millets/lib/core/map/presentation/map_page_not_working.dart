import 'package:agro_millets/colors.dart';
import 'package:agro_millets/core/chat/constants/color_constants.dart';
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
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:math';
import '../../../models/user.dart';
import 'package:agro_millets/data/cache/app_cache.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:geocoding/geocoding.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  late MapManager mapManager;
  MapController mapController = MapController();
  List<LatLng> farmerCoordinates = [];
  var logged_in_user = appState.value.user;
  late LatLng map_latlng_view= LatLng(logged_in_user!.latitude, logged_in_user!.longitude);
  // List<Marker> markers = [];
  List<Location> search_locations = [];


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
        Coordinate coord1 = Coordinate(user.latitude,user.longitude); // Berlin coordinates
        Coordinate coord2 = Coordinate(logged_in_user?.latitude , logged_in_user?.longitude); // Paris coordinates

        double distance = distanceBetweenCoordinates(coord1, coord2);

        return Marker(
            point: LatLng(user.latitude,user.longitude),
            builder: (ctx) => GestureDetector(

              onTap: () {

                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    // contentPadding: EdgeInsets.zero, // Remove default padding
                    title:  Row(
                      // Remove default padding
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          // color: Colors.,
                        ),
                        SizedBox(width: 5),
                        Text(
                          user.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                    ,
                    content: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.category_outlined),
                              SizedBox(width: 5),
                              Text(
                                user.userType,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // Icon(Icons.category_outlined),
                              Icon(Icons.nordic_walking_outlined),
                              SizedBox(width: 5),
                              Text(
                                distance.toStringAsFixed(2) + " KM",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.phone_android_outlined),
                              // Container(
                              //   // padding: EdgeInsets.only(right: 5.0), // Adjust the left padding as needed
                              //   child:
                              // )
                              // ,
                              // SizedBox(width: 5),
                              Text(
                                user.phone,
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                padding: EdgeInsets.only(right: 0.0),
                                onPressed: () => UrlLauncher.launch('tel://${user.phone}'),
                                icon: const Icon(MdiIcons.phoneDial,color: Colors.green,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.red),
                  // SizedBox(width: 8),
                  //
                  Container(
                    color: Colors.white, // Background color
                    child: Text(
                      distance.toStringAsFixed(2) + " KM",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        color: Colors.blue, // Font color
                      ),
                    ),
                  ),

                ],
              ),
            ),
            // builder: (BuildContext context) {
            //   return Icon(Icons.location_on, color: Colors.red);
            // },

          );
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmers Near You"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TypeAheadField<Placemark?>(
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  hintText: 'Search location...',
                ),
              ),
              suggestionsCallback: (pattern) async {
                List<Location> locations = await locationFromAddress(pattern);
                List<Placemark?> placemarks = [];
                for (var location in locations) {
                  List<Placemark> temp = await placemarkFromCoordinates(
                      location.latitude, location.longitude);
                  if (temp.isNotEmpty) {
                    placemarks.add(temp.first);
                  }
                }
                return placemarks;
              },
              itemBuilder: (context, Placemark? suggestion) {
                return ListTile(
                  title: Text(suggestion?.name ?? ''),
                  subtitle: Text(suggestion?.locality ?? '' +','+ '${suggestion?.subAdministrativeArea}' + ',' + '${suggestion?.country}' ),
                );
              },
              onSuggestionSelected: (Placemark? suggestion) async {
                if (suggestion != null) {
                  print(suggestion.name);
                  print('------');
                  print(suggestion);
                  search_locations = await locationFromAddress(suggestion.name??'');
                  map_latlng_view = LatLng(search_locations[0].latitude, search_locations[0].longitude);
                  print(search_locations[0].latitude);
                  print(search_locations[0].longitude);
                  print(mapController.move(
                    map_latlng_view,
                    9.0,
                  ));
                  // setState(() {
                  //   markers = [
                  //     Marker(
                  //       point: LatLng(
                  //         locations[0].latitude,
                  //         locations[0].longitude,
                  //       ),
                  //       builder: (_) => Icon(
                  //         Icons.location_on,
                  //         color: Colors.red,
                  //       ),
                  //     ),
                  //   ];
                  // });
                }
              },

            ),
          ),
          Expanded(
          child: SizedBox(
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: mapController,

                    options: MapOptions(
                      center: map_latlng_view,
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
                            mapController.move(mapController.center, 18);
                          },
                          child: Icon(Icons.add),
                        ),
                        SizedBox(height: 10),
                        FloatingActionButton(
                          onPressed: () {
                            mapController.move(mapController.center, 8);
                          },
                          child: Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}


class Coordinate {
  final double? latitude;
  final double? longitude;

  Coordinate(this.latitude, this.longitude);
}

double distanceBetweenCoordinates(Coordinate coord1, Coordinate coord2) {
  const double earthRadius = 6371; // Radius of the Earth in kilometers

  double degToRad(double? degree) {
    return degree! * (pi / 180);
  }

  double lat1 = degToRad(coord1.latitude);
  double lon1 = degToRad(coord1.longitude);
  double lat2 = degToRad(coord2.latitude);
  double lon2 = degToRad(coord2.longitude);

  double dlat = lat2 - lat1;
  double dlon = lon2 - lon1;

  double a = pow(sin(dlat / 2), 2) +
      cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c;
  return distance;
}