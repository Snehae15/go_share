import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Home/Home.dart';
import '../connect.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Car pooling/current_location.dart';

class alert extends StatefulWidget {
  const alert({Key? key}) : super(key: key);

  @override
  State<alert> createState() => _alertState();
}

class _alertState extends State<alert> {
  String formatTime(DateTime time) {
    DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(time);
  }
    // Future<void> location_access() async {
    //   await controller.getCurrentLocation().toString();
    //   location=   controller.currentLocation!;
    //   locality=controller.locality;
    //   street=controller.street;
    //   sublocality=controller.sublocality;
    //   subadminstrative=controller.subadminstartive;
    //   controller.currentLocation==null?'--no Location selected--':
    //   controller.currentLocation==null?'--wait for a while to get location or tap again below after a few seconds':
    //   controller.currentLocation!;
    //   latitude=controller.myLat;
    //   longitude=controller.myLong;
    //   print('My Latitude :$latitude');
    //   print('My longitude:$longitude');
    //   print('My Location :$locality');
    //   print('My Location :$street');
    //   print('My Location :$sublocality');
    //   print('My Location :$subadminstrative');
    //
    // }
  void main() {
    DateTime currentTime = DateTime.now();
    String formattedTime = formatTime(currentTime);
    print(formattedTime); // Output: 3:30 PM
  }
  var latitude, longitude;
  String? locality='locality';
  String? street='street';
  String? sublocality='sublocality';
  String?subadminstrative='subadminstrative';
  var location = 'click';
  var date=DateTime.now();
  var messageController = TextEditingController();
  var log_id;
  final complaintkey=GlobalKey<FormState>();
  var text="help";
  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? log_id = prefs.getString('loginId');
    return log_id;
  }
  @override
  void initState(){
    super.initState();
    getLoginId();

  }
  Future<void> register()  async {
    var log_id=await getLoginId();
    if (log_id!=null) {
      print("log_id:$log_id");
    }
    else
    {
      print('error');

    }
    var data={
      'message':messageController.text,
      'date':date.toString(),
      'time':formatTime(DateTime.now()),
      'log_id':log_id,
      'lat':latitude.toString(),
      'long':longitude.toString(),
      'locality':locality,
      'street':street,
      'sublocality':sublocality,
    };
    print(data);
    print('inside fuction');
    var response=await post(Uri.parse("${con.url}help/help.php"),body: data);
    print(response.body);
    if (response.statusCode==200) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Alerted')));
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>home()),(Route <dynamic> route )=>false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  GetBuilder(
      init: LocationController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: complaintkey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back_ios_new)),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text('GO Share',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff068DA9),
                              fontFamily: 'Times New Roman'
                          ),),
                        ),

                        //app name
                      ],
                    ),
                    SizedBox(height: 80,),

                    SizedBox(
                      width: 340,
                      child: TextFormField(
                        validator: (val){
                          if ( val!.isEmpty){
                            return 'Field reqired';
                          }
                        },
                        controller: messageController,
                        style: TextStyle(color: Colors.black,fontSize: 20),
                        maxLines: 10,
                        decoration: InputDecoration(
                            fillColor: Colors.black12,
                            filled: true,
                            hintText: 'Register your complaints here',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 50,
                        width: 220,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black45,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)
                                )
                            ),
                            onPressed: () async {
                              if (complaintkey.currentState!.validate()){

                                      await controller.getCurrentLocation().toString();
                                      location=   controller.currentLocation!;
                                      locality=controller.locality;
                                      street=controller.street;
                                      sublocality=controller.sublocality;
                                      subadminstrative=controller.subadminstartive;
                                      controller.currentLocation==null?'--no Location selected--':
                                      controller.currentLocation==null?'--wait for a while to get location or tap again below after a few seconds':
                                      controller.currentLocation!;
                                      latitude=controller.myLat;
                                      longitude=controller.myLong;
                                register();

                              }
                            }, child:Text(
                          ' Tap Twice!!',style: TextStyle(color: Colors.white,fontSize: 25
                        ),
                        ) ),
                      ),
                    ),
                    // OutlinedButton(
                    //   style: ButtonStyle(
                    //       side: MaterialStateProperty.all(BorderSide(color: Colors.black))),
                    //   onPressed: () async {
                    //     await controller.getCurrentLocation().toString();
                    //     location=   controller.currentLocation!;
                    //     locality=controller.locality;
                    //     street=controller.street;
                    //     sublocality=controller.sublocality;
                    //     subadminstrative=controller.subadminstartive;
                    //     controller.currentLocation==null?'--no Location selected--':
                    //     controller.currentLocation==null?'--wait for a while to get location or tap again below after a few seconds':
                    //     controller.currentLocation!;
                    //     latitude=controller.myLat;
                    //     longitude=controller.myLong;
                    //     print('My Latitude :$latitude');
                    //     print('My longitude:$longitude');
                    //     print('My Location :$locality');
                    //     print('My Location :$street');
                    //     print('My Location :$sublocality');
                    //     print('My Location :$subadminstrative');
                    //     if (complaintkey.currentState!.validate()) {
                    //       register();
                    //
                    //     }                      },
                    //   child: Center(
                    //     child: ListTile(
                    //       title: Text(
                    //         'Double tap!!!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                    //       ),
                    //       leading: Icon(Icons.location_on,color: Colors.red,size: 45,),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },

    );
  }
}
