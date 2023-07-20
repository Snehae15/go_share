import 'dart:convert';
import 'package:corider/Car%20pooling/c4.dart';
import 'package:corider/Car%20pooling/c4edit.dart';
import 'package:corider/Login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../connect.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'gm4edit.dart';
class gm4 extends StatefulWidget {
  const gm4({Key? key}) : super(key: key);

  @override
  State<gm4> createState() => _gm4State();
}

class _gm4State extends State<gm4> {
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
    var response = await post(Uri.parse("${con.url}goods_movement/view_goods.php"),body: data);
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
          width: MediaQuery.of(context).size.width,

          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>c4()));
                    }, child: Text('Ride offered',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Times New Roman',
                          color:Color(0xff068DA9), )),)



            //app name
                    ],
                ),
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>gm4edit(
                                              starting_point: snapshot.data[index]['starting_point'],
                                              destination: snapshot.data[index]['destination'],
                                              time: snapshot.data[index]['time'],
                                              date: snapshot.data[index]['date'],
                                              vehicle_no: snapshot.data[index]['vehicle_no'],
                                              gm_id: snapshot.data[index]['gm_id'],
                                            )
                                            )
                                            );
                                          }, icon: Icon(Icons.edit))      ,
                                          IconButton(onPressed: (){
                                            gm_id=snapshot.data[index]['gm_id'];
                                            setState(() {
                                              // deletedata();
                                            });
                                          }, icon: Icon(Icons.delete))      ,

                                        ],
                                      ),
                                      Container(
                                          height: 300,
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Image(image:  AssetImage('assets/home/h (2).jpeg'),fit: BoxFit.contain,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text('${snapshot.data[index]['starting_point']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                  Text('${snapshot.data[index]['destination']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                                                ],
                                              ),

                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text('${snapshot.data[index]['vehicle_no']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                  // Text('${snapshot.data[index]['log_id']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                  // Text('${snapshot.data[index]['pool_id']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text('${snapshot.data[index]['date']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                  Text('${snapshot.data[index]['time']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

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
          ),
        ),

      ),
    );
  }
}
