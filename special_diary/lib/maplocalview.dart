import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latlong;

import 'components/appbarwidget.dart';

class MapLocationView extends StatefulWidget {
  const MapLocationView({super.key});

  @override
  State<MapLocationView> createState() => _MapLocationViewState();
}

class _MapLocationViewState extends State<MapLocationView> {
  // DatabaseHandler handler = DatabaseHandler();
  var value = Get.arguments ?? "_";
  late Position currentPosition;
  late double latData;
  late double lngData;
  late MapController mapController;
  late bool canRun;
  late String name;



  @override
  void initState() {
    super.initState();
    //현재 위치에서 버튼 누른걸로 되어있어서 초기값은 0
    mapController = MapController();
    canRun = false;
    name = value[1];
    latData = value[2];
    lngData = value[3];

    //홈과 연결되는 Permission 받아와야 함
    //ios,android info.list 추가한 이유
    checkLocationPermission();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        toolbarHeight: 65,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 45, 0),
          child: AppbarTitle(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            
            gradient: LinearGradient(
              colors: [Theme.of(context).colorScheme.primaryContainer,Theme.of(context).colorScheme.surfaceTint,],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
              
          ),),
        // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: canRun
      ? flutterMap()
      : Center(
        child: CircularProgressIndicator(),
      )

    );
  }
 //---Function---

  //Map뜨기전에 동작하는 것 - await를 통해서 허가받을때까지 대기
checkLocationPermission() async { 
  LocationPermission permission = await Geolocator.checkPermission();
  //await하니까 뒤에 segment 함께 보임 
  if(permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
  }

  if(permission == LocationPermission.deniedForever){ //안쓴다 그러면 return
  return;
  }

  if(permission == LocationPermission.whileInUse || 
  permission == LocationPermission.always){ //사용할때만 쓰거나 항상 쓴다그러면 위치 값 받아오자   
  getCurrentLocation();
  }
}

getCurrentLocation() async{
  await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best,
    forceAndroidLocationManager: true).then((Position) {
      currentPosition = Position;
      canRun = true;
      latData = value[2];
      lngData = value[3];
      setState(() {});
      print(latData.toString()+ ":" +lngData.toString());
    }).catchError((e){
      print(e);
    });
}


Widget flutterMap(){
  return FlutterMap(
    mapController: mapController,
    options: MapOptions(
      initialCenter: latlong.LatLng(latData, lngData),
      initialZoom: 17.0
    ), 
    children: [ //지도를 다 찢어서 보여줌 - 한꺼번에 보여주면 오래걸려서 
    TileLayer(
      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
    ),
    MarkerLayer(
      markers: [
        Marker(
          width: 100,
          height: 100,
          point: latlong.LatLng(latData, lngData), 
          child: Column( //Text,icon 넣을 수 있음.
            children: [ 
              Text('',
              style: TextStyle(fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 30, 34)),
              ),
              Icon(
                Icons.pin_drop_sharp,
                size: 55,
                color: Color.fromARGB(255, 68, 118, 255),) //마커 클릭하면 글자 보여줌
            ],
          ),
          ),
      ])
    ]
    );
}



}//END