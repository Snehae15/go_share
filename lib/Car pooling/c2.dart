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
  Future<dynamic> getdata() async {
    var response = await post(Uri.parse("${con.url}offer_pool/view_pool.php"));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 &&
        jsonDecode(response.body)[0]['result'] == 'success') {
      flag = 1;
      return jsonDecode(response.body);
    } else {
      flag = 0;
      const CircularProgressIndicator();
      Text('no data');
    }
  }

  Future<dynamic> search(var result) async {
    // var log_id=await getLoginId();
    print(result);
    var data = {'destination': result};
    // var data={'log_id':'1'};

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
      const CircularProgressIndicator();
      Text('no data');
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
                      icon: Icon(Icons.arrow_back_ios_new)),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'GO Share',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff068DA9),
                          fontFamily: 'Times New Roman'),
                    ),
                  ),

                  //app name
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
                      fontSize: 20),
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
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20))),
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
                            ))
                          : ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => offerpool(
                                                starting_point:
                                                    snapshot.data[index]
                                                        ['starting_point'],
                                                destination: snapshot
                                                    .data[index]['destination'],
                                                vehicle_no: snapshot.data[index]
                                                    ['vehicle_no'],
                                                time: snapshot.data[index]
                                                    ['time'],
                                                date: snapshot.data[index]
                                                    ['date'])));
                                  },
                                  child: ListTile(
                                    title: Text(
                                        '${snapshot.data[index]['destination']}'),
                                    subtitle: Text(
                                        '${snapshot.data[index]['starting_point']}'),
                                    trailing: Column(
                                      children: [
                                        Text('${snapshot.data[index]['time']}'),
                                        Text('${snapshot.data[index]['date']}'),
                                      ],
                                    ),
                                  ),
                                );
                              });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchableList extends StatefulWidget {
  const SearchableList({Key? key, required this.dataList}) : super(key: key);
  final List dataList;
  @override
  State<SearchableList> createState() => _SearchableListState();
}

class _SearchableListState extends State<SearchableList> {
  @override
  void initState() {
    datas = widget.dataList;
    super.initState();
  }

  List datas = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            if (value.isEmpty) {
              setState(() {
                datas = widget.dataList;
              });
            } else {
              datas = [];
              for (var singleItem in widget.dataList) {
                if (singleItem['destination']
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase())) {
                  setState(() {
                    datas.add(singleItem);
                  });
                }
              }
            }
          },
          decoration: const InputDecoration(
            hintText: "Search Destination",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: datas.length,
              itemBuilder: (context, index) {
                var jobData = datas[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          update(id: 'pool_id');
                          Fluttertoast.showToast(msg: "Applied for pool");
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>const ()));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black12),
                        ),
                        child: const Text("Apply for pool"),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }

  void update({required String id}) {
    var data = {"id": id};
    var response = post(Uri.parse('${con.url}offer_pool.php'), body: data);
  }
}
