import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class gm_details_page extends StatefulWidget {
  gm_details_page({
    Key? key,
    required this.starting_point,
    required this.destination,
    required this.vehicle_no,
    required this.time,
    required this.date,
  }) : super(key: key);

  var starting_point, destination, vehicle_no, time, date;

  @override
  State<gm_details_page> createState() => _gm_details_pageState();
}

class _gm_details_pageState extends State<gm_details_page> {
  // Function to initiate a phone call
  void _makePhoneCall() async {
    String phoneNumber = "<YOUR_PHONE_NUMBER>"; // Replace with the actual phone number you want to call
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'GO Share',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xff068DA9),
            fontFamily: 'Times New Roman',
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    height: 250,
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
                        SizedBox(height: 10),
                        Text(
                          widget.vehicle_no,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Times New Roman',
                            fontWeight: FontWeight.w500,
                            color: Colors.black38,
                          ),
                        ),
                        SizedBox(height: 10),
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
                              onPressed: _makePhoneCall, // Call the function to make a phone call
                              child: Text('Contact'),
                            ),
                          ],
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
