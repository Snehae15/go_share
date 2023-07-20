import 'dart:convert';
import 'package:corider/Goods%20Movement/gm_details.dart';
import 'package:corider/Group%20trip/gt_detail.dart';
import '../Car pooling/offerpool.dart';
import '../connect.dart';
import 'package:corider/Home/h1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Home.dart';
class h2 extends StatefulWidget {
  const h2({Key? key}) : super(key: key);

  @override
  State<h2> createState() => _h2State();
}

class _h2State extends State<h2> {
  var flag=0;
  Future<dynamic> pool() async {
    var response = await post(Uri.parse("${con.url}search/pool.php"));
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
  Future<dynamic> trip() async {
    var response = await post(Uri.parse("${con.url}search/trip.php"));
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
  Future<dynamic> goods() async {
    var response = await post(Uri.parse("${con.url}search/goods.php"));
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



  //////search////////////
  // String _searchQuery = '';
  // List<dynamic> _searchResults = [];
  // Future<void> _performSearch(String query) async {
  //   final response = await post(Uri.parse("${con.url}search/pool.php"), body: {'query': query});
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     setState(() {
  //       _searchResults = data['destination'];
  //
  //     });
  //   }
  // }
  //////search////////////
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
        }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('GO Share  ',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff068DA9),
                    fontFamily: 'Times New Roman'
                ),),

              ),

            ],
          ), //app name
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                  // onChanged: (value) {
                  //   setState(() {
                  //     _searchQuery = value;
                  //     print("Inside=$_searchQuery");
                  //   });
                  //   _performSearch(value);
                  // },
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20
                ),
                decoration: InputDecoration(
                  hintText: 'Destination',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Color(0xff068DA9),
                  prefixIcon: Icon(Icons.search_rounded,color: Colors.white,),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)

                      ),
                  focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)

                  )
                ),
              ),
            ),
            // Container(
            //   height:200,
            //   child:FutureBuilder(
            //   future: pool(),
            //   builder: (context,snapshot) {
            //     if (snapshot.hasError) {
            //       print(snapshot.error);
            //     }
            //     // if (!snapshot.hasData ||snapshot.data.length==0) {
            //     // return const Center(
            //     // child: CircularProgressIndicator(),
            //     // );
            //     // }
            //     return flag == 0 ? Center(child: CircularProgressIndicator()) :
            //      ListView.builder(
            //             itemCount: _searchResults.length,
            //             itemBuilder: (context, index) {
            //               final result = _searchResults[index];
            //               return ListTile(
            //           title: Text('${snapshot.data[index]['destination']}',style: TextStyle(fontSize: 25,color: Color(0xff068DA9),fontWeight: FontWeight.w600),),
            //                 // subtitle: Text(result['description']),
            //                 // Customize the display of search results as needed
            //               );
            //             },
            //           );
            //         }
            //     )
            //   ,
            //
            //               ),
            Container(
              height: 200,
              child: FutureBuilder(
                  future: pool(),
                  builder: (context,snapshot){
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    // if (!snapshot.hasData ||snapshot.data.length==0) {
                    // return const Center(
                    // child: CircularProgressIndicator(),
                    // );
                    // }
                    return flag==0?Center(child: CircularProgressIndicator()):
                    ListView.builder(

                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (contex,index){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>offerpool(
                                  starting_point: snapshot.data[index]['starting_point'],
                                  destination: snapshot.data[index]['destination'],
                                  vehicle_no: snapshot.data[index]['vehicle_no'],
                                  time: snapshot.data[index]['time'],
                                  date: snapshot.data[index]['date'])));
                            },
                              child:
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color:Color(0xff068DA9)
                                    )

                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Cars offered',style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xff068DA9)),),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('${snapshot.data[index]['destination']}',style: TextStyle(fontSize: 25,color: Color(0xff068DA9),fontWeight: FontWeight.w600),),
                                        Text('${snapshot.data[index]['starting_point']}',style: TextStyle(fontSize: 20,color:Color(0xff068DA9),fontWeight: FontWeight.w600)),
                                        Text('${snapshot.data[index]['time']}',style: TextStyle(fontSize: 20,color: Color(0xff068DA9),fontWeight: FontWeight.w200)),
                                        Text('${snapshot.data[index]['date']}',style: TextStyle(fontSize: 20,color: Color(0xff068DA9),fontWeight: FontWeight.w200)),
                                      ],
                                    ),
                                  ),
                                  // subtitle: Text('${snapshot.data[index]['starting_point']}'),
                                  // trailing: Column(
                                  //   children: [
                                  //
                                  //   ],
                                  //   ),
                                  // ),
                                ),
                              ));
                        });
                  }),
            ),//pools
            Container(
              height: 200,
              child: FutureBuilder(
                  future: goods(),
                  builder: (context,snapshot){
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    // if (!snapshot.hasData ||snapshot.data.length==0) {
                    // return const Center(
                    // child: CircularProgressIndicator(),
                    // );
                    // }
                    return flag==0?Center(child: CircularProgressIndicator()):
                    ListView.builder(

                      scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (contex,index){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>gm_details_page(
                                  starting_point: snapshot.data[index]['starting_point'],
                                  destination: snapshot.data[index]['destination'],
                                  vehicle_no: snapshot.data[index]['vehicle_no'],
                                  time: snapshot.data[index]['time'],
                                  date: snapshot.data[index]['date'])));
                            },
                            child:
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.teal)

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Good Carrier',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.teal),),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('${snapshot.data[index]['destination']}',style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.w600),),
                                      Text('${snapshot.data[index]['starting_point']}',style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.w600)),
                                      Text('${snapshot.data[index]['time']}',style: TextStyle(fontSize: 20,color: Colors.teal,fontWeight: FontWeight.w200)),
                                      Text('${snapshot.data[index]['date']}',style: TextStyle(fontSize: 20,color: Colors.teal,fontWeight: FontWeight.w200)),
                                    ],
                                  ),
                                ),
                                // subtitle: Text('${snapshot.data[index]['starting_point']}'),
                                // trailing: Column(
                                //   children: [
                                //
                                //   ],
                              //   ),
                              // ),
                          ),
                            ));
                        });
                  }),
            ),//goods
            Container(
              height: 200,
              child: FutureBuilder(
                  future: trip(),
                  builder: (context,snapshot){
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    // if (!snapshot.hasData ||snapshot.data.length==0) {
                    // return const Center(
                    // child: CircularProgressIndicator(),
                    // );
                    // }
                    return flag==0?Center(child: CircularProgressIndicator()):
                    ListView.builder(

                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (contex,index){
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>gt_detail(
                                  starting_point: snapshot.data[index]['starting_point'],
                                  destination: snapshot.data[index]['destination'],
                                  vehicle_no: snapshot.data[index]['vehicle_no'],
                                  date: snapshot.data[index]['date'],
                                first_name: snapshot.data[index]['first_name'],
                                last_name: snapshot.data[index]['last_name'],
                                mobile_no: snapshot.data[index]['mobile_no'],
                                vehicle_type: snapshot.data[index]['vehicle_type'],
                                group_name: snapshot.data[index]['group_name'],)));
                            },
                              child:
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.blueGrey,

                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Group Trips',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blueGrey,),),
                                        SizedBox(height: 5,),
                                        Text('${snapshot.data[index]['group_name']}'.toUpperCase(),style: TextStyle(fontSize: 25,color: Colors.blueGrey,fontWeight: FontWeight.w500)),
                                        Text('${snapshot.data[index]['destination']}',style: TextStyle(fontSize: 25,color: Colors.blueGrey,fontWeight: FontWeight.w600),),
                                        Text('${snapshot.data[index]['starting_point']}',style: TextStyle(fontSize: 25,color: Colors.blueGrey,fontWeight: FontWeight.w600)),
                                        Text('${snapshot.data[index]['date']}',style: TextStyle(fontSize: 20,color: Colors.blueGrey,fontWeight: FontWeight.w200)),
                                      ],
                                    ),
                                  ),
                                  // subtitle: Text('${snapshot.data[index]['starting_point']}'),
                                  // trailing: Column(
                                  //   children: [
                                  //
                                  //   ],
                                  //   ),
                                  // ),
                                ),
                              ));
                        });
                  }),
            ),//trip



          ],
        ),
      ),


    );
  }
}
