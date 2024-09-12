import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:soul_connection/models/event.module.dart';

class CustomMapboxMap extends StatefulWidget {
  final LatLng startPosition;
  final List<EventModel> markersData;

  const CustomMapboxMap({
    super.key,
    required this.startPosition,
    required this.markersData,
  });

  @override
  CustomMapboxMapState createState() => CustomMapboxMapState();
}

class CustomMapboxMapState extends State<CustomMapboxMap> {
  MapboxMapController? mapController;
  Symbol? selectedSymbol;
  String? popupContent;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    mapController?.onSymbolTapped.add(_onSymbolTapped);
    _addMarkers();
  }

  void _addMarkers() async {
    print("\n\n\nadding markers");
    for (var marker in widget.markersData) {
      print("new marker on " + marker.locationX + " " + marker.locationY);
      await mapController?.addSymbol(SymbolOptions(
        geometry: LatLng(
            double.parse(marker.locationX), double.parse(marker.locationY)),
        iconImage: 'marker-15',
        iconSize: 3,
      ));
      print("marker added");
    }
  }

  void _onSymbolTapped(Symbol symbol) {
    print("symbol tapped");
    setState(() {
      selectedSymbol = symbol;
      popupContent = widget.markersData
          .firstWhere((marker) =>
              double.parse(marker.locationX) ==
                  symbol.options.geometry!.latitude &&
              double.parse(marker.locationY) ==
                  symbol.options.geometry!.longitude)
          .name;
    });
  }

  Widget _buildPopup() {
    return Positioned(
      top: 50,
      left: 10,
      right: 10,
      child: popupContent != null
          ? Container(
              padding: EdgeInsets.all(8),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(popupContent!)),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        popupContent = null;
                      });
                    },
                  )
                ],
              ),
            )
          : SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapboxMap(
          accessToken:
              'pk.eyJ1IjoiY2lyZW1pYSIsImEiOiJjbTB5MDFqZWwwaHBmMmtzZ2R4dWJ0cDY0In0.yNUksIJYkIUMX3pD4dLq0A',
          initialCameraPosition: CameraPosition(
            target: widget.startPosition,
            zoom: 11,
          ),
          onMapCreated: _onMapCreated,
        ),
        _buildPopup(),
      ],
    );
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}
