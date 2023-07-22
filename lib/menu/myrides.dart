import 'dart:convert';
import 'package:corider/menu/addride.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../connect.dart';

class myrides extends StatefulWidget {
  const myrides({Key? key}) : super(key: key);

  @override
  State<myrides> createState() => _myridesState();
}

class _myridesState extends State<myrides> {
  var flag;
  var ride_id;

  Future<dynamic> getdata() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print(sp);

    var data = {
      "id": sp,
    };
    print('>>>>>>>$data');
    var response = await post(Uri.parse("${con.url}my_rides/read.php"), body: data); // Send the 'log_id' in the POST request body
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 &&
        jsonDecode(response.body)[0]['result'] == 'success') {
      flag = 1;
      return jsonDecode(response.body);
    } else {
      flag = 0;
      return null; // Return null to handle no data case
    }
  }

  Future<dynamic> deletedata() async {
    print(ride_id);
    var data = {'ride_id': ride_id.toString()};
    var response =
    await post(Uri.parse("${con.url}my_rides/delete.php"), body: data);
    if (jsonDecode(response.body)['result'] == 'Success') {
      return jsonDecode(response.body);
    } else {
      return null; // Return null to handle error case
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => addride()),
                      );
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: getdata(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          var data = snapshot.data;
                          return ListTile(
                            leading: Column(
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${data[index]['time']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              '${data[index]['destination']}',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Times New Roman',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${data[index]['date']}'),
                                Text('Status: ${data[index]['status']}'), // Display the 'status' field
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                ride_id = int.parse(data[index]['ride']);
                                setState(() {
                                  deletedata();
                                });
                              },
                              icon: Icon(Icons.delete_outline),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            thickness: 3,
                          );
                        },
                        itemCount: snapshot.data.length,
                      );
                    } else {
                      // No data case
                      return Center(
                        child: Text('No data available.'),
                      );
                    }
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
