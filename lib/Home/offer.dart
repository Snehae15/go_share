import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../connect.dart';

class AllOffer extends StatefulWidget {
  const AllOffer({Key? key}) : super(key: key);

  @override
  State<AllOffer> createState() => _AllOfferState();
}

class _AllOfferState extends State<AllOffer> {
  var log_id;
  var flag;

  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log_id = prefs.getString('loginId');
    print('log_id: $log_id');
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
    var response = await http.post(
      Uri.parse("${con.url}offer/offers.php"),
      body: data,
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData is List && responseData.isNotEmpty && responseData[0]['result'] == 'success') {
        flag = 1;
        return responseData;
      } else {
        // Check if the response contains "message" with "id not provided"
        if (responseData is Map && responseData.containsKey('message') && responseData['message'] == 'id not provided') {
          // Display the appropriate message in the UI
          flag = 0;
          return [];
        } else {
          // Handle other error cases if needed
          throw Exception('Failed to fetch data');
        }
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Offers'),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
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
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            print(snapshot.error);
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
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
                                            color: Colors.blueGrey,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${snapshot.data[index]['company_name']}'.toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:25 ,
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Container(
                                                        height: 190,
                                                        width: 380,
                                                        color: Colors.grey,
                                                        child: Image.network(
                                                          con.uploads + snapshot.data[index]['voucher'],
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      // Add other data fields to display
                                                    ],
                                                  ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
