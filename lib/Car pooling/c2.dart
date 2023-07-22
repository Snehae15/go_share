import 'dart:convert';
import 'package:corider/Car%20pooling/offerpool.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import '../connect.dart';

class c2 extends StatefulWidget {
  const c2({Key? key}) : super(key: key);

  @override
  State<c2> createState() => _c2State();
}

class _c2State extends State<c2> {
  var flag = 0;
  late String result;

  Future<List<dynamic>> getdata() async {
    var response = await post(Uri.parse("${con.url}offer_pool/view_pool.php"));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 &&
        jsonDecode(response.body)[0]['result'] == 'success') {
      flag = 1;
      return jsonDecode(response.body);
    } else {
      flag = 0;
      return []; // Return an empty list to handle no data case
    }
  }

  Future<List<dynamic>> search(String result) async {
    print(result);
    var data = {'destination': result};
    print("destination=$result");
    var response =
    await post(Uri.parse("${con.url}offer_pool/search.php"), body: data);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 &&
        jsonDecode(response.body)['result'] == 'success') {
      flag = 1;
      return jsonDecode(response.body);
    } else {
      flag = 0;
      return []; // Return an empty list to handle no data case
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
                  onChanged: (value) {
                    setState(() {
                      result = value;
                      print(" Inside =  $result");
                    });
                    search(result);
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Car/Bike Pooling',
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
                        ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.teal,
                        color: Colors.red,
                      ),
                    )
                        : ListView.builder(
                      itemCount: snapshot.data?.length ?? 0, // Add null check
                      itemBuilder: (context, index) {
                        var data = snapshot.data?[index];
                        if (data == null) return SizedBox.shrink(); // Add null check
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => offerpool(
                                  starting_point: data['starting_point'],
                                  destination: data['destination'],
                                  vehicle_no: data['vehicle_no'],
                                  time: data['time'],
                                  date: data['date'],
                                  status: data['status'] ?? 'N/A',
                                  pool_id:data['pool_id'], // Add null check for status
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text('${data['destination']}'),
                            subtitle: Text('${data['starting_point']}'),
                            trailing: Column(
                              children: [
                                Text('${data['time']}'),
                                Text('${data['date']}'),
                                Text('${data['status'] ?? 'N/A'}'), // Display 'N/A' if status is not available
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
