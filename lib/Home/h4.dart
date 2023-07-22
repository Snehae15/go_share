import 'dart:convert';
import 'package:corider/Home/h4edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../connect.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class h4 extends StatefulWidget {
  const h4({Key? key}) : super(key: key);

  @override
  State<h4> createState() => _h4State();
}

class _h4State extends State<h4> {
  String? log_id;
  var flag;
  var email;
  var mobile_no;

  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log_id = prefs.getString('loginId');
    print('log_id:$log_id');
    return log_id;
  }

  Future<Map<String, dynamic>?> getdata() async {
    var logId = await getLoginId();
    print('logId: $logId');
    var data = {'log_id': logId ?? ''};

    var response = await post(Uri.parse("${con.url}login/profile.php"), body: data);
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData != null && responseData is List && responseData.isNotEmpty) {
        var firstResponse = responseData[0]; // Access the first element of the array
        if (firstResponse['result'] == 'success') {
          flag = 1;
          return firstResponse;
        }
      }
    }

    flag = 0;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        actions: [
          Row(
            children: [
              Text(
                'GO Share  ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff068DA9),
                  fontFamily: 'Times New Roman',
                ),
              ),
            ],
          ), //app name
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<Map<String, dynamic>?>(
                future: getdata(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Return a loading indicator while waiting for data
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Handle the error case
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data == null) {
                    // Handle the case when data is null
                    return Text('No data available');
                  } else {
                    // Data is available, access the keys safely using the null-aware operator
                    var data = snapshot.data!;
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 30,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('First Name'.toUpperCase(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                                          Text(':'.toUpperCase(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                                          Text('${data['first_name']}'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xff068DA9),),),
                                          SizedBox(width: 10,),
                                        ],
                                      ),
                                      Divider(thickness: 1,),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Last Name'.toUpperCase(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                                          Text(':'.toUpperCase(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                                          Text('${data['last_name']}'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xff068DA9),),),
                                          SizedBox(width: 10,),
                                        ],
                                      ),
                                      Divider(thickness: 1,),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Mobile No'.toUpperCase(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                                          Text(':'.toUpperCase(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                                          Text('${data['mobile_no']}'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xff068DA9),),),
                                          SizedBox(width: 10,),
                                        ],
                                      ),
                                      Divider(thickness: 1,),
                                      SizedBox(height: 10,),
                                      SingleChildScrollView(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Email'.toUpperCase(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                                            Text(':', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),),
                                            Text('${data['email']}'.toLowerCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xff068DA9),),),
                                            SizedBox(width: 10,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
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
    );
  }
}
