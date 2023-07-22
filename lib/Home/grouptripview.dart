import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../connect.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class GrouptripView extends StatefulWidget {
  const GrouptripView({Key? key}) : super(key: key);

  @override
  State<GrouptripView> createState() => _GrouptripViewState();
}

class _GrouptripViewState extends State<GrouptripView> {
  var log_id;
  var flag;

  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log_id = prefs.getString('loginId');
    print('log_id:$log_id');
    return log_id;
  }

  @override
  void initState() {
    super.initState();
    getLoginId();
  }

  Future<dynamic> getdata() async {
    var log_id = await getLoginId();
    print(log_id);
    var data = {'log_id': log_id.toString()};
    var response =
    await post(Uri.parse("${con.url}group_trip/view.php"), body: data);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 &&
        jsonDecode(response.body)[0]['result'] == 'success') {
      flag = 1;
      return jsonDecode(response.body);
    } else {
      flag = 0;
      return [];
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
                    //app name
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                        future: getdata(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error);
                          }
                          return flag == 0
                              ? Center(
                            child: Text('No data'),
                          )
                              : Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 5,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 250,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${snapshot.data[index]['group_name']}'.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.teal,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Text(
                                                      '${snapshot.data[index]['starting_point']}'
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '${snapshot.data[index]['destination']}'
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(
                                                    '${snapshot.data[index]['first_name']}'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${snapshot.data[index]['last_name']}'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(
                                                    '${snapshot.data[index]['vehicle_no']}'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${snapshot.data[index]['vehicle_type']}'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(
                                                    '${snapshot.data[index]['mobile_no']}'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${snapshot.data[index]['date']}'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
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
                        },
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
