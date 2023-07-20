import 'dart:convert';
import 'package:corider/Car%20pooling/c2.dart';
import 'package:corider/Car%20pooling/c3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'current_location.dart';
import 'location.dart';
import 'connect_location.dart';
class c1 extends StatefulWidget {
  c1({Key? key}) : super(key: key);
  @override
  State<c1> createState() => _c1State();
}

class _c1State extends State<c1> {
  // var mapLat;
  // var mapLong;
  var latitude, longitude;
  String? locality='locality';
  String? street='street';
  String? sublocality='sublocality';
  String? subadminstrative='subadminstrative';
  var location = 'click';

  senddata() async {
  var data={
    'locality':locality,
    'street':street,
    'sublocality':sublocality,
    'subadminstrative':subadminstrative,
    'latitude':latitude.toString(),
    'longitude':longitude.toString(),
  };
  var response =await post(Uri.parse("${con.url}location/insert.php"),body: data);
  print(response.body);
  if (jsonEncode(response.statusCode)==200) {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location Registerd')));

    });
  }  
  }
  @override
  void initState() {
    super.initState();
  }

  // void initState(){
  //   super.initState();
  //   print(widget.lat);
  //   print(widget.long);
  //
  //   mapLat=double.parse(widget.lat);
  //   mapLong=double.parse(widget.long);
  //   setState(() {
  //     MapUtils.openMap(mapLat, mapLong);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      init: LocationController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new)),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'GO Share',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff068DA9),
                              fontFamily: 'Times New Roman'),
                        ),
                      ),

                      //app name
                    ],
                  ),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 10,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('You are now on',style:
                                        TextStyle(
                                        fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black45),

                                ),
                                Icon(Icons.location_on,size: 55,color: Colors.red,)
                              ],
                            ),
                            SizedBox(height: 50,),

                            Text(locality!,
                                style: locality == 'locality'
                                    ? TextStyle(
                                        fontSize: 25, fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,color: Colors.teal)),
                            SizedBox(height: 15,),
                            Text(street!,
                            style: street == 'street'
                                ? TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold,color: Colors.teal)
                                : TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,color: Colors.teal)),
                            Text(sublocality!,
                                style: sublocality == 'sublocality'
                                    ? TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)
                                    : TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            Text(subadminstrative!,
                                style: subadminstrative == 'subadminstrative'
                                    ? TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)
                                    : TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),

                          ],
                        )),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none
                    ),
                    onPressed: (){
                    MapUtils.openMap(latitude, longitude);
                  }, child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map,color: Colors.teal,),
                        Text('Veiw in map',style: TextStyle(color: Colors.teal),)
                      ],
                    ),
                  ),


                  SizedBox(
                    height: 5,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      // visible: (widget.reportType=='missing')?false:true,

                      child: OutlinedButton(
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(BorderSide(color: Colors.black))),
                        onPressed: () async {
                          await controller.getCurrentLocation().toString();
                          location=   controller.currentLocation!;
                          locality=controller.locality;
                          street=controller.street;
                          sublocality=controller.sublocality;
                          subadminstrative=controller.subadminstartive;
                          controller.currentLocation==null?'--no Llocation selected--':
                          controller.currentLocation==null?'--wait for a while to get location or tap again below after a few seconds':
                          controller.currentLocation!;
                          latitude=controller.myLat;
                          longitude=controller.myLong;
                          print('My Lattitude :$latitude');
                          print('My longitude:$longitude');
                          print('My Location :$locality');
                          print('My Location :$street');
                          print('My Location :$sublocality');
                          print('My Location :$subadminstrative');
                          senddata();
                        },
                        child: Center(
                          child: ListTile(
                            title: Text(
                              'Get My Location',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                            ),
                            leading: Icon(Icons.location_on,color: Colors.red,size: 45,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Card(
                    elevation: 0.1,
                    child: Container(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>c2()));
                            },
                            child: Text(
                              'Find Pool',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ))),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 0.1,
                    child: Container(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => c3()));
                            },
                            child: Text(
                              'Offer Pool',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ))),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
