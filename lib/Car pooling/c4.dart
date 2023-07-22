import 'dart:convert';
import 'package:corider/Car%20pooling/c4edit.dart';
import 'package:corider/Goods%20Movement/gm4.dart';
import 'package:corider/Login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../connect.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class c4 extends StatefulWidget {
  const c4({Key? key}) : super(key: key);

  @override
  State<c4> createState() => _c4State();
}

class _c4State extends State<c4> {
  var log_id;
  var flag;
  var pool_id;

  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log_id = prefs.getString('loginId');
    print('log_id:$log_id');
    return log_id ?? "";
  }

  @override
  void initState() {
    super.initState();
    getLoginId();
  }

  Future<dynamic> deletedata() async {
    print(pool_id);
    var data = {'pool_id': pool_id.toString()};
    var response = await post(Uri.parse("${con.url}offer_ride_menu/delete.php"),
        body: data);
    if (jsonDecode(response.body)['result'] == 'Success') {
      return jsonDecode(response.body);
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Future<dynamic> getdata() async {
    var log_id = await getLoginId();
    print(log_id);
    var data = {'log_id': log_id.toString()};
    var response = await post(
        Uri.parse("${con.url}offer_ride_menu/offer_ride.php"),
        body: data);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 &&
        jsonDecode(response.body)[0]['result'] == 'success') {
      flag = 1;
      return jsonDecode(response.body);
    } else {
      flag = 0;
      return null; // Return null in case of no data
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
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'GO Share',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff068DA9),
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => gm4()),
                        );
                      },
                      child: Text(
                        'Goods Movement',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Times New Roman',
                          color: Color(0xff068DA9),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                FutureBuilder(
                  future: getdata(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('No data'));
                    } else {
                      var data = snapshot.data;
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 5,
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // IconButton(
                                        //   onPressed: () {
                                        //     Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //         builder: (context) => c4edit(
                                        //           starting_point: data[index]
                                        //               ['starting_point'],
                                        //           destination: data[index]
                                        //               ['destination'],
                                        //           time: data[index]['time'],
                                        //           date: data[index]['date'],
                                        //           vehicle_no: data[index]
                                        //               ['vehicle_no'],
                                        //           pool_id: data[index]
                                        //               ['pool_id'],
                                        //         ),
                                        //       ),
                                        //     );
                                        //   },
                                        //   icon: const Icon(Icons.edit),
                                        // ),
                                        IconButton(
                                          onPressed: () {
                                            pool_id = data[index]['pool_id'];
                                            setState(() {
                                              deletedata();
                                            });
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 300,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          const Image(
                                            image: AssetImage(
                                                'assets/home/h (3).jpeg'),
                                            fit: BoxFit.contain,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                '${data[index]['starting_point']}',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '${data[index]['destination']}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                '${data[index]['vehicle_no']}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                '${data[index]['date']}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                '${data[index]['time']}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
