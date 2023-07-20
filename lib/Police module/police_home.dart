import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../connect.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class police_home extends StatefulWidget {
  const police_home({super.key});

  @override
  State<police_home> createState() => _police_homeState();
}

class _police_homeState extends State<police_home> {
  var flag;
  var log_id;

  Future<dynamic> getdata() async {
    var response = await post(Uri.parse("${con.url}help/new.php"));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 && jsonDecode(response.body)[0]['result'] == 'success') {
      flag = 1;
      return jsonDecode(response.body);
    } else {
      flag = 0;
      // Returning null here, since CircularProgressIndicator cannot be returned directly.
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'GO Share',
            style: GoogleFonts.gruppo(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color(0xff068DA9),
              // fontFamily: 'Times New Roman'
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff068DA9),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a progress indicator while waiting for data.
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.teal,
                  ),
                );
              } else if (snapshot.hasError) {
                // Handle any error that occurred during data fetching.
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.data == null || snapshot.data.length == 0) {
                // Handle the case when there is no data available.
                return Center(
                  child: Text('No data'),
                );
              } else {
                // Display the ListView with the fetched data.
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: 310,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.teal)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${snapshot.data[index]['lat']}',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.red),
                                  ),
                                  Text(
                                    '${snapshot.data[index]['long']}',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '${snapshot.data[index]['locality']}'.toUpperCase(),
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
                                  ),
                                  Text(
                                    '${snapshot.data[index]['sublocality']}',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${snapshot.data[index]['street']}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.red),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '${snapshot.data[index]['first_name']}'.toUpperCase(),
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey),
                                  ),
                                  Text(
                                    '${snapshot.data[index]['last_name']}',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${snapshot.data[index]['mobile_no']}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${snapshot.data[index]['message']}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${snapshot.data[index]['date']}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
