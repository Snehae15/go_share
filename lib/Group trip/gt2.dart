import 'dart:convert';
import 'package:corider/Goods%20Movement/gm_details.dart';
import 'package:corider/Group%20trip/gt_detail.dart';
import 'package:corider/connect.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class gt2 extends StatefulWidget {
  const gt2({Key? key}) : super(key: key);

  @override
  State<gt2> createState() => _gt2State();
}

class _gt2State extends State<gt2> {
  var flag = 0;
  var searchController = TextEditingController();

  Future<dynamic> getdata({String? startingPoint, String? destination}) async {
    Map<String, String> data = {};
    if (startingPoint != null) {
      data['starting_point'] = startingPoint;
    }
    if (destination != null) {
      data['destination'] = destination;
    }

    var response = await post(Uri.parse("${con.url}group_trip/view.php"), body: data);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 && jsonDecode(response.body)[0]['result'] == 'success') {
      flag = 1;
      return jsonDecode(response.body);
    } else {
      flag = 0;
      return null;
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: searchController,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Destination',
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Color(0xff068DA9),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) {
                    // You can trigger the search here based on user input
                    // For example, you can call the search function
                    // getdata(startingPoint: value);
                    setState(() {
                      // Trigger the search when the user types
                      // For example, getdata(startingPoint: value);
                      // or getdata(destination: value);
                      // You can customize the search based on your requirements.
                      // For simplicity, let's search based on the destination only.
                      getdata(destination: value);
                    });
                  },
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
                                builder: (context) => gt_detail(
                                  starting_point: snapshot.data[index]['starting_point'],
                                  destination: snapshot.data[index]['destination'],
                                  vehicle_no: snapshot.data[index]['vehicle_no'],
                                  date: snapshot.data[index]['date'],
                                  first_name: snapshot.data[index]['first_name'],
                                  last_name: snapshot.data[index]['last_name'],
                                  mobile_no: snapshot.data[index]['mobile_no'],
                                  vehicle_type: snapshot.data[index]['vehicle_type'],
                                  group_name: snapshot.data[index]['group_name'],
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text('${snapshot.data[index]['destination']}'.toUpperCase()),
                            subtitle: Text('${snapshot.data[index]['starting_point']}'.toUpperCase()),
                            trailing: Column(
                              children: [
                                Text('${snapshot.data[index]['date']}'),
                                Text('${snapshot.data[index]['vehicle_type']}'.toUpperCase()),
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
