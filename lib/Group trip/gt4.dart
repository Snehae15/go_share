import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../connect.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'gt5.dart';
class gt4 extends StatefulWidget {
  const gt4({Key? key}) : super(key: key);

  @override
  State<gt4> createState() => _gt4State();
}

class _gt4State extends State<gt4> {
  var log_id;
  var flag;
  var gm_id;

  // Future<String?> check() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // SharedPreferences pref = await getSharedPrefrences('prefs,Contex.MODE_PRIVATE');
  //   // log_id = prefs.getString('loginId');
  //   var log=prefs.contains('loginId');
  //   print('log_id:$log_id');
  //   return log_id;
  // }
  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log_id = prefs.getString('loginId');
    print('log_id:$log_id');
    return log_id;
  }

  void initstate(){
    super.initState();
    getLoginId();

  }
  // Future <dynamic> deletedata() async{
  //   print(gm_id);
  //   var data={'gm_id':gm_id.toString()};
  //   // var response=await post(Uri.parse("${con.utl}delete.php"),body:data);
  //   var response=await post(Uri.parse("${con.url}offer_ride_menu/delete.php"),body: data);
  //   if (jsonDecode(response.body)['result']=='Success') {
  //     return jsonDecode(response.body);
  //   }
  //   else
  //   {
  //     const Center(
  //       child: CircularProgressIndicator(),
  //     );
  //   }
  // }
  Future<dynamic> getdata() async {
    var log_id=await getLoginId();
    print(log_id);
    var data={'log_id':log_id.toString()};
    // var data={'log_id':'1'};

    print("log_id1=$log_id");
    var response = await post(Uri.parse("${con.url}group_trip/view.php"),body: data);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 && jsonDecode(response.body)[0]['result']=='success') {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
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
                SizedBox(height: 50,),

                Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      FutureBuilder(
                          future: getdata(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print(snapshot.error);
                            }
                            return flag==0?
                            Center(child: CircularProgressIndicator()):
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width:  MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {

                                  return  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 5,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                IconButton(onPressed: (){
                                                  print(snapshot.data[index]['starting_point']);
                                                  print(snapshot.data[index]['destination']);
                                                  print(snapshot.data[index]['date']);
                                                  print(snapshot.data[index]['vehicle_no']);
                                                  print(snapshot.data[index]['vehicle_type']);
                                                  print(snapshot.data[index]['mobile_no']);
                                                  print(snapshot.data[index]['group_name']);

                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>gt5(
                                                    starting_point: snapshot.data[index]['starting_point'],
                                                    destination: snapshot.data[index]['destination'],
                                                    date: snapshot.data[index]['date'],
                                                    vehicle_no: snapshot.data[index]['vehicle_no'],
                                                    gt_id: snapshot.data[index]['gt_id'],
                                                    group_name: snapshot.data[index]['group_name'],
                                                    vehicle_type: snapshot.data[index]['vehicle_type'],
                                                  )
                                                  )
                                                  );
                                                }, icon: Icon(Icons.edit))      ,
                                                // IconButton(onPressed: (){
                                                //   gm_id=snapshot.data[index]['gt_it'];
                                                //   setState(() {
                                                //     // deletedata();
                                                //   });
                                                // }, icon: Icon(Icons.delete))      ,

                                              ],
                                            ),
                                            Container(
                                                width: MediaQuery.of(context).size.width,
                                                height: 250,
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 10,),

                                                    Text('${snapshot.data[index]['group_name']}'.toUpperCase(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.teal),),
                                                    SizedBox(height: 10,),

                                                    SingleChildScrollView(
                                                      scrollDirection: Axis.horizontal,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Text('${snapshot.data[index]['starting_point']}'.toUpperCase(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Colors.black),),
                                                          SizedBox(width: 10,),
                                                          Text('${snapshot.data[index]['destination']}'.toUpperCase(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Colors.black),),

                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10,),

                                                    Row(

                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Text('${snapshot.data[index]['first_name']}'.toUpperCase(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Colors.black),),
                                                        Text('${snapshot.data[index]['last_name']}'.toUpperCase(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Colors.black),),

                                                      ],
                                                    ),




                                                    SizedBox(height: 10,),
                                                    Row(

                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Text('${snapshot.data[index]['vehicle_no']}'.toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.black),),
                                                        Text('${snapshot.data[index]['vehicle_type']}'.toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.black),),

                                                      ],
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Row(

                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Text('${snapshot.data[index]['mobile_no']}'.toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.black),),
                                                        Text('${snapshot.data[index]['date']}'.toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.black),),

                                                      ],
                                                    ),

                                                  ],
                                                )
                                            )
                                          ],
                                        ),
                                      )


                                  );
                                },
                              ),
                            );
                          }
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}
