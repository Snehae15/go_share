import 'dart:convert';
import 'package:corider/Goods%20Movement/gm_details.dart';
import 'package:corider/connect.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'gm5.dart';

class gm2 extends StatefulWidget {
  const gm2({Key? key}) : super(key: key);

  @override
  State<gm2> createState() => _gm2State();
}

class _gm2State extends State<gm2> {
  var flag = 0;

  Future<dynamic> getdata() async {
    var response =
    await post(Uri.parse("${con.url}goods_movement/read_goods.php"));
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'View Offered Goods Carrier',
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Color(0xff068DA9),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Container(
                height: 500,
                child: FutureBuilder(
                  future: getdata(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    }
                    return flag == 0
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => gm_details_page(
                                  starting_point:
                                  snapshot.data[index]['starting_point'],
                                  destination:
                                  snapshot.data[index]['destination'],
                                  vehicle_no:
                                  snapshot.data[index]['vehicle_no'],
                                  time: snapshot.data[index]['time'],
                                  date: snapshot.data[index]['date'],
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text('${snapshot.data[index]['destination']}'),
                            subtitle: Text('${snapshot.data[index]['starting_point']}'),
                            trailing: Column(
                              children: [
                                Text('${snapshot.data[index]['time']}'),
                                Text('${snapshot.data[index]['date']}'),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
