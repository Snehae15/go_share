import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../connect.dart';

class offerpool extends StatefulWidget {
  offerpool({
    Key? key,
    required this.starting_point,
    required this.destination,
    required this.vehicle_no,
    required this.time,
    required this.date,
    required this.status, required this.pool_id,
  }) : super(key: key);

  final String starting_point;
  final String destination;
  final String vehicle_no;
  final String time;
  final String date;
  final String status;
  final String pool_id;

  @override
  State<offerpool> createState() => _offerpoolState();
}

class _offerpoolState extends State<offerpool> {
  bool isCompleted = false;
  String poolId = ''; // Initialize poolId with an empty string

  _makePhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void markCompleted() {
    setState(() {
      isCompleted = true;
    });
    updateStatus();
  }

  Future<void> updateStatus() async {
    var data = {
      "pool_id": widget.pool_id,
    };
    print('>>>>>>>$data');

    var response = await http.post(
      Uri.parse("${con.url}offer_pool/updatestatus.php"),
      body: data,
      // headers: {'Content-Type': 'application/json'},
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 &&
        jsonDecode(response.body)[0]['result'] == 'success') {
      print("Status updated to 'completed'");
    } else {
      print("Failed to update status");
    }
  }

  Future<void> _fetchPoolId() async {
    var response = await http.get(
      Uri.parse("${con.url}offer_pool/view_pool.php"),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body); // Print the response body

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var fetchedPoolId = responseData['pool_id']
          .toString(); // Convert pool_id to a string
      setState(() {
        poolId = fetchedPoolId;
      });
      print("Fetched pool_id: $poolId");
    } else {
      print("Failed to fetch pool_id");
    }
  }

  Future<void> _setupData() async {
    await _fetchPoolId(); // Fetch the pool_id before setting up the data

    SharedPreferences spref = await SharedPreferences.getInstance();
    var poolId = spref.getString('pool_id');

    if (poolId == null) {
      // Pool id is not set, handle this case if needed.
      // For example, you can show an error message or return to the previous screen.
    } else {
      // Pool id is set, use it directly to update the status.
      markCompleted();
    }
  }

  @override
  void initState() {
    // Call the _setupData() method when the widget is initialized.
    _setupData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.starting_point,
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Times New Roman',
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          "to",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Times New Roman',
                            fontWeight: FontWeight.bold,
                            color: Colors.black12,
                          ),
                        ),
                        Text(
                          widget.destination,
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Times New Roman',
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.vehicle_no,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Times New Roman',
                            fontWeight: FontWeight.w500,
                            color: Colors.black38,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              widget.time,
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Times New Roman',
                                fontWeight: FontWeight.w500,
                                color: Colors.black45,
                              ),
                            ),
                            Text(
                              widget.date,
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Times New Roman',
                                fontWeight: FontWeight.w500,
                                color: Colors.black45,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                _makePhoneCall('PHONE_NUMBER_TO_CALL');
                              },
                              child: Text('Contact'),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            markCompleted();
                          },
                          child: Text('Completed'),
                        ),
                        // Display the status as 'Completed' if the button is clicked
                        if (isCompleted)
                          Text(
                            'Status: Completed',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
