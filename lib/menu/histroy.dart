import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../connect.dart';

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  Future<List<dynamic>> viewHistory() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print(sp);

    var data = {
      "id": sp,
    };
    print('>>>>>>>$data');

    var response =
    await http.post(Uri.parse('${con.url}offer_pool/history.php'),
        body: data);
    print(response.body);
    var res = jsonDecode(response.body);
    return res;
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
              ],
            ),
            SizedBox(
              height: 30,
            ),
            FutureBuilder(
              future: viewHistory(),
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
                  List<dynamic> historyList = snapshot.data as List<dynamic>;
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        var history = historyList[index];
                        return ListTile(
                          leading: Column(
                            children: [

                              Text(
                                '${history['time']}',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          title: Text(
                            '${history['destination']}',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${history['date']}'),
                              Text('Status: ${history['status']}'),
                            ],
                          ),
                          trailing: Text(
                            '${history['vehicle_no']}',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Times New Roman',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 3,
                        );
                      },
                      itemCount: historyList.length,
                    ),
                  );
                } else {
                  // No data case
                  return Center(
                    child: Text('No data available.'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
