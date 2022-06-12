import 'package:distance_calculator/utils/loaction_service.dart';
import 'package:distance_calculator/widget/textField.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_maps/secrets.dart'; // Stores the Google Maps API Key
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';


class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
   CameraPosition _initialLocation = CameraPosition(
    target: LatLng(37.4219983, -122.084),
    zoom: 15.5
  );

// For controlling the view of the Map
  GoogleMapController? mapController;
  Marker? _origin;
  Marker? _destination;
// For storing the current position
  Position? _currentPosition;
  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final destinationAddressFocusNode = FocusNode();
  String _currentAddress = '';
  String _destinationAddress = '';
  String _startAddress = '';

  Set<Marker> markers = {};
  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

// Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('////....CURRENT POSITION OOOO.....: $_currentPosition');
        print('....C-POSITION lati.....: ${position.latitude}');
        print('....C-POSITION long.....: ${position.longitude}');
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      // Taking the most probable result
      Placemark place = p[0];

      setState(() {
        // Structuring the address
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        // Update the text of the TextField
        startAddressController.text = _currentAddress;
        // Setting the user's present location as the starting address
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  // Future<bool> _calculateDistance() async {
  //   try {
  //     List<Location>? startPlacemark = await locationFromAddress(_startAddress);
  //     List<Location>? destinationPlacemark = await locationFromAddress(_startAddress);
  //       double startLatitude = _startAddress == _currentAddress
  //       ? _currentPosition.latitude
  //       : startPlacemark[0].latitude;

  //   } catch (e) {
  //   }
  // }



  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // @override
  // void dispose() {
  //   mapController!.dispose();
  //   super.dispose();
  // }

  Marker _startMarker = Marker(
    markerId: MarkerId('_startPoint'),
    infoWindow: InfoWindow(title: 'start'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(
        37.4219983,
        -122.085749655962,
      )
  
  );

  Marker _endMarker = Marker(
    markerId: MarkerId('_endPoint'),
    infoWindow: InfoWindow(title: 'end'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(
        37.4329619983,
        -122.08832357078792,
      )
  
  );


// Polyline variable
  final Polyline _startPoline = Polyline(
    polylineId: PolylineId('startId'),
    points: [
LatLng(
        37.4219983,
        -122.085749655962,
      ),
      LatLng(
      37.4329619983,
      -122.08832357078792,
    )

    ],
    width: 5,
    color: Colors.red
    );


    // polygon variable

    static final Polygon _startPolygon = Polygon(
      polygonId: PolygonId('_sPolygon'),
      points:[
        LatLng(
        37.4219983,
        -122.085749655962,
      ),
      LatLng(
      37.4329619983,
      -122.08832357078792,
    ),

   LatLng(37.417, -122.092),
   LatLng(37.435, -122.098),

      ],
      strokeWidth: 5,
      fillColor: Colors.transparent

       );


  @override
  Widget build(BuildContext context) {
    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        height: height,
        width: width,
        child: Scaffold(
          body: Stack(
            children: [
    
              // TODO: Add Map View
              GoogleMap(
                // markers: Set<Marker>.from(markers),
                initialCameraPosition: _initialLocation,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                // polygons: {_startPolygon},
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                markers: {
                  _startMarker,
                  _endMarker
                  // if (_origin != null) _origin!,
                  // if (_destination != null) _destination!
                },
                polylines:{
                  _startPoline
                } ,
              ),
    
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.blue.shade100,
                            child: InkWell(
                              child: const SizedBox(
                                  width: 50, height: 50, child: Icon(Icons.add)),
                              onTap: () {
                                mapController!.animateCamera(
                                  CameraUpdate.zoomIn(),
                                );
                              },
                            ),
                          
                          ),
                        ),
                        SizedBox(height: 20),
                        ClipOval(
                          child: Material(
                            color: Colors.blue.shade100,
                            child: InkWell(
                              splashColor: Colors.blue,
                              child: const SizedBox(
                                height: 50,
                                width: 50,
                                child: Icon(Icons.remove),
                              ),
                              onTap: () {
                                mapController!
                                    .animateCamera(CameraUpdate.zoomOut());
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
    
               SafeArea(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                    child: ClipOval(
                      child: Material(
                        color: Colors.orange.shade100, // button color
                        child: InkWell(
                          splashColor: Colors.orange, // inkwell color
                          child: const SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(Icons.my_location),
                          ),
                          onTap: () {
                            mapController!.animateCamera(
                              CameraUpdate.newCameraPosition(_initialLocation
                                  // CameraPosition(
                                  //   target: LatLng(
                                  //     _currentPosition.latitude,
                                  //     _currentPosition.longitude,
                                  //   ),
                                  //   zoom: 18.0,
                                  // ),
                                  ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
    
    
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      width: width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Places',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            SizedBox(height: 10),
                            textInput(
                                label: 'Start',
                                hint: 'Choose starting point',
                                prefixIcon: Icon(Icons.looks_one),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.my_location),
                                  onPressed: () {
                                    startAddressController.text = _currentAddress;
                                    _startAddress = _currentAddress;
                                  },
                                ),
                                controller: startAddressController,
                                focusNode: startAddressFocusNode,
                                width: width,
                                locationCallback: (String value) {
                                  print('...this is sSTART ADD.. $value');
                                  setState(() {
                                    _startAddress = value;
                                    print('...Na the new address be this.. $_startAddress');
                                  });
                                }),
                            SizedBox(height: 10),
                            textInput(
                                label: 'Destination',
                                hint: 'Choose destination',
                                prefixIcon: Icon(Icons.looks_two),
                                controller: destinationAddressController,
                                focusNode: destinationAddressFocusNode,
                                width: width,
                                
                                
                                locationCallback: (String value) {
                                  print('...this is dEstination ADD.. $value');
                                  setState(() {
                                    _destinationAddress = value;
                                  });
                                }),
                            SizedBox(height: 10),
                            // Visibility(
                            //   visible: _placeDistance == null ? false : true,
                            //   child: Text(
                            //     'DISTANCE: $_placeDistance km',
                            //     style: TextStyle(
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () {
                                print('the searching location ');
                                LocationService().getPlaceId(_startAddress);
                              },
                              //  (_startAddress != '' &&
                              //         _destinationAddress != '')
                              //     ? () async {
                              //         startAddressFocusNode.unfocus();
                              //         desrinationAddressFocusNode.unfocus();
                              //         // setState(() {
                              //         //   if (markers.isNotEmpty) markers.clear();
                              //         //   if (polylines.isNotEmpty)
                              //         //     polylines.clear();
                              //         //   if (polylineCoordinates.isNotEmpty)
                              //         //     polylineCoordinates.clear();
                              //         //   _placeDistance = null;
                              //         // });
    
                              //         _calculateDistance().then((isCalculated) {
                              //           if (isCalculated) {
                              //             ScaffoldMessenger.of(context)
                              //                 .showSnackBar(
                              //               SnackBar(
                              //                 content: Text(
                              //                     'Distance Calculated Sucessfully'),
                              //               ),
                              //             );
                              //           } else {
                              //             ScaffoldMessenger.of(context)
                              //                 .showSnackBar(
                              //               SnackBar(
                              //                 content: Text(
                              //                     'Error Calculating Distance'),
                              //               ),
                              //             );
                              //           }
                              //         });
                              //       }
                              //     : null,
    
                              // color: Colors.red,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(20.0),
                              // ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Show Route'.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
    
            ],
          ),
        ),
      ),
    );
  }
}
