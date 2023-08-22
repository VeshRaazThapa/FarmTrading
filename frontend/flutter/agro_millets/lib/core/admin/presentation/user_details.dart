import 'package:flutter/material.dart';

import '../../../models/user.dart';
import 'package:geocoding/geocoding.dart';

class UserDetails extends StatefulWidget {
<<<<<<< HEAD
  
  const UserDetails({Key? key}) : super(key: key);
=======
  final User user;
  const UserDetails({super.key, required this.user});
>>>>>>> acd1d618f5dd9068af6989b56f9497ad4931d6e3

  @override
  State<UserDetails> createState() => _UserDetailsState();
}
var locationName;


Future<String> getLocationName(double latitude, double longitude) async {
  try {
    print(latitude);
    print(longitude);
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      return placemark.name ?? '';
    }
    return '';
  } catch (e) {
    print('Error getting location name: $e');
    return '';
  }
}



class _UserDetailsState extends State<UserDetails> {
  @override

  void initState() {
    getLocation();
    super.initState();
  }
  Future<void> getLocation() async {
    String name = await getLocationName(this.widget.user.latitude,this.widget.user.longitude);
    setState(() {
      locationName = name;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.white,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) => SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'User Details',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CloseButton()
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.16),
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text('User Name'),
                            trailing: Text('${this.widget.user.name}'),
                          ),
                          ListTile(
                            title: Text('Email'),
                            trailing: Text('${this.widget.user.email}'),
                          ),
                          ListTile(
                            title: Text('Phone'),
                            trailing: Text('${this.widget.user.phone}'),
                          ),
                          ListTile(
                            title: Text('Address'),
                            trailing: Text('${locationName}'),
                          ),
                        ],
                      ),
                    ),
                   
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
