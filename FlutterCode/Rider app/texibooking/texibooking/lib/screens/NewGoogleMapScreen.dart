import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../utils/Constants.dart';
import '../utils/Extensions/app_common.dart';

class NewGoogleMapScreen extends StatefulWidget {
  @override
  NewGoogleMapScreenState createState() => NewGoogleMapScreenState();
}

class NewGoogleMapScreenState extends State<NewGoogleMapScreen> {
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  PickResult? selectedPlace;
  bool showPlacePickerInContainer = false;
  bool showGoogleMapInContainer = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PlacePicker(
        //TODO
        apiKey: googleMapAPIKey,
        hintText: 'Find a place....',
        searchingText: 'Please wait',
        selectText: 'Select place',
        outsideOfPickAreaText: 'Place not in area',
        initialPosition: kInitialPosition,
        useCurrentLocation: true,
        selectInitialPosition: true,
        usePinPointingSearch: true,
        usePlaceDetailSearch: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        automaticallyImplyAppBarLeading: false,
        autocompleteLanguage: '',
        onMapCreated: (GoogleMapController controller) {
          //
        },
        onPlacePicked: (PickResult result) {
          setState(() {
            selectedPlace = result;
            log(selectedPlace!.formattedAddress);
            Navigator.pop(context, selectedPlace);
          });
        },
        onMapTypeChanged: (MapType mapType) {
          //
        },
      ),
    );
  }
}
