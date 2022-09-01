import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_wioso/const.dart';
import 'package:flutter_wioso/widgets/buttons.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 20),
        child: MyFloatingActionButton(
          Icon(
            Icons.menu,
            color: primaryColor,
            size: 29,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SafeArea(
        child: MapSlidingUpPanel(),
      ),
    );
  }
}

class MapSlidingUpPanel extends StatefulWidget {
  const MapSlidingUpPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<MapSlidingUpPanel> createState() => _MapSlidingUpPanelState();
}

class _MapSlidingUpPanelState extends State<MapSlidingUpPanel> {
  bool _isExpand = false;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      onPanelOpened: () {
        setState(() {
          _isExpand = true;
        });
      },
      onPanelClosed: () {
        setState(() {
          _isExpand = false;
        });
      },
      minHeight: 220,
      maxHeight: MediaQuery.of(context).size.height * 0.7,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      boxShadow: const [
        BoxShadow(
          blurRadius: 20.0,
          color: secondaryColor,
        ),
      ],
      panel: MapPanelContent(_isExpand),
      body: Stack(
        children: const [
          Map(),
          Positioned(
            right: 13.5,
            bottom: 270,
            child: MyFloatingActionButton(
              Icon(
                Icons.gps_fixed,
                color: secondaryColor,
                size: 29,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapPanelContent extends StatelessWidget {
  final bool isExpand;

  const MapPanelContent(
    this.isExpand, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 8,
        right: 16,
        bottom: 16,
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 110,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 40,
                      color: secondaryColor,
                    ),
                    dots(),
                    const Icon(
                      Icons.flag,
                      size: 40,
                      color: primaryColor,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      MyTextFormField(
                        'Punkt początkowy',
                        Icon(
                          Icons.location_on,
                          color: secondaryColor,
                        ),
                        'Danków',
                        readOnly: true,
                      ),
                      MyTextFormField(
                        'Punkt końcowy',
                        Icon(
                          Icons.flag,
                          color: secondaryColor,
                        ),
                        'Władysławów',
                        readOnly: true,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          isExpand ? const Spacer() : const SizedBox(height: 15),
          PrimaryButton('Zatwierdź', () {}),
        ],
      ),
    );
  }

  Column dots() {
    return Column(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: const BoxDecoration(
            color: secondaryColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 10,
          width: 10,
          decoration: const BoxDecoration(
            color: secondaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class Map extends StatelessWidget {
  const Map({
    Key? key,
  }) : super(key: key);

  static final List<LatLng> _points = List.generate(
    cords.length,
    (index) => LatLng(
      cords[index]['latitude'],
      cords[index]['longitude'],
    ),
  );

  static final LatLng _center = LatLng(
      _points[(_points.length / 2).floor()].latitude,
      _points[(_points.length / 2).floor()].longitude);

  static final List<Marker> _markers = [
    Marker(
      point: _points.first,
      anchorPos: AnchorPos.align(
        AnchorAlign.top,
      ),
      builder: (context) => const Icon(
        Icons.location_on,
        size: 40,
      ),
    ),
    Marker(
      point: _points.last,
      anchorPos: AnchorPos.align(
        AnchorAlign.top,
      ),
      builder: (context) => const Icon(
        Icons.flag,
        color: primaryColor,
        size: 40,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: _center,
        zoom: 11,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/wioso/cky1r5yru6a6114o6u560jmxm/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoid2lvc28iLCJhIjoiY2txdGR0OWtxMWliNTJxbmJjZWFsNDVodSJ9.Ip6t7geNojoutadecWBltg',
          subdomains: ['a', 'b', 'c'],
        ),
        PolylineLayerOptions(
          polylines: [
            Polyline(
              points: _points,
              color: primaryColor,
              strokeWidth: 2,
            ),
          ],
        ),
        MarkerLayerOptions(markers: _markers),
      ],
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String label;
  final Icon icon;
  final bool readOnly;
  final String text;

  const MyTextFormField(
    this.label,
    this.icon,
    this.text, {
    Key? key,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        initialValue: text,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.white60,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
