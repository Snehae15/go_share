import 'dart:convert';
import 'package:corider/Car%20pooling/c1.dart';
import 'package:corider/Car%20pooling/c4.dart';
import 'package:corider/Goods%20Movement/gm1.dart';
import 'package:corider/Group%20trip/gt1.dart';
import 'package:corider/Group%20trip/gt4.dart';
import 'package:corider/Home/h4.dart';
import 'package:corider/Login/login.dart';
import 'package:corider/Police%20module/police_home.dart';
import 'package:corider/Rental%20cars/r1.dart';
import 'package:corider/menu/help.dart';
import 'package:corider/menu/histroy.dart';
import 'package:corider/menu/myrides.dart';
import 'package:corider/menu/review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Car pooling/current_location.dart';
import '../menu/complaints.dart';
import '../connect.dart';
import 'grouptripview.dart';
import 'help.dart';
// import 'package:corider/Login/login.dart';

class h1 extends StatefulWidget {
  const h1({Key? key}) : super(key: key);

  @override
  State<h1> createState() => _h1State();
}

class _h1State extends State<h1> {
  var lat,long;
  var log_id;
  var flag;
  var email;
  var mobile_no;
  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log_id = prefs.getString('loginId');
    print('log_id:$log_id');
    return log_id;
  }

  Future<dynamic> getdata() async {
    var log_id=await getLoginId();
    print(log_id);
    var data={'log_id':log_id};
    // var data={'log_id':'1'};

    print("log_id1=$log_id");
    var response = await post(Uri.parse("${con.url}login/profile.php"),body: data);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 && jsonDecode(response.body)['result']=='success') {
      flag=1;
      return jsonDecode(response.body);

    }
    else {
      flag=0;
      const CircularProgressIndicator();
      Text('no data');
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('GO Share', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff068DA9),
                    fontFamily: 'Times New Roman'
                ),),
              ),
              IconButton(onPressed: () {},
                  icon: Icon(
                    Icons.notifications_outlined, color: Colors.amber,size: 40,)),
              // IconButton(onPressed: (){
              // }, icon: Icon(Icons.menu,color: Colors.black,)),
            ],
          ), //app name
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){  Navigator.push(context,MaterialPageRoute(builder: (context) => help()));
                  }, icon: Icon(Icons.help_outline)),
                  IconButton(onPressed: (){
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text('Are you sure you want to logout!'),
                        actions: [
                          TextButton(onPressed: () {
                            Navigator.pop(context);
                          }, child: Text('No')),
                          TextButton(onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => login()));
                          }, child: Text('Yes')),
                        ],
                      );
                    });
                  }, icon: Icon(Icons.logout)),
                ],
              ),
              DrawerHeader(
                child: FutureBuilder(
                    future: getdata(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      return flag == 0 ?
                      Center(child: CircularProgressIndicator()) :
                      Container(
                          height:137,
                          child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    // CircleAvatar(),
                                    // Text('${snapshot.data['email']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                                  ],
                                );
                              }));
                    }),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => myrides()));
                },
                child: ListTile(
                  leading: Icon(Icons.mode_of_travel),
                  title: Text('My Rides'),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => history()));
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text('History'),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => complaints()));
                },
                child: ListTile(
                  leading: Icon(Icons.comment),
                  title: Text('Add Complaints'),
                ),
              ), Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => police_home()));
                },
                child: ListTile(
                  leading: Icon(Icons.comment),
                  title: Text('View Complaints'),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => review()));
                },
                child: ListTile(
                  leading: Icon(Icons.reviews_outlined),
                  title: Text('Review'),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => GrouptripView()));
                },
                child: ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Group created'),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => c4()));
                },
                child: ListTile(
                  leading: Icon(Icons.local_offer_outlined),
                  title: Text('Offer ride'),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('GO Share',style: GoogleFonts.gruppo(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff068DA9),
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        splashColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>alert()));
        },
        child: Icon(Icons.add_alert_outlined, size: 30,),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all( 8.0,),
              child: Text('Select your ride',
                style: GoogleFonts.gruppo(color:Color(0xff068DA9),fontSize: 25, fontWeight: FontWeight.w500),),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
                height: 300,
                width: double.infinity,
                child: Image(image: AssetImage('assets/login/c.png'),fit: BoxFit.cover,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all( 8.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Color(0xff068DA9)),
                ),
                width: double.infinity,
                child: OutlinedButton(
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(BorderSide(color: Color(0xff068DA9)))),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>c1()));
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => c1(lat: 10.976036, long: 76.225441,)));
                  },
                  child: Text(
                    'Car/Bike Pooling',
                    style: TextStyle(color: Color(0xff068DA9), fontSize: 22),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                width: double.infinity,
                child: OutlinedButton(
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(BorderSide(color: Color(0xff068DA9)))),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => gm1()));
                  },
                  child: Text(
                    'Goods Movement',
                    style: TextStyle(color:  Color(0xff068DA9), fontSize: 22),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                width: double.infinity,
                child: OutlinedButton(
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(BorderSide(color: Color(0xff068DA9)))),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => r1()));
                  },
                  child: Text(
                    'Rental Service',
                    style: TextStyle(color: Color(0xff068DA9), fontSize: 22),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all( 8.0),
              child: Container(
                height: 60,
                width: double.infinity,
                child: OutlinedButton(
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(BorderSide(color: Color(0xff068DA9)))),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => gt1()));
                  },
                  child: Text(
                    'Group Trip',
                    style: TextStyle(color:  Color(0xff068DA9), fontSize: 22),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
