import 'dart:convert';
import '../connect.dart';
import 'package:corider/Rental%20cars/r2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class r1 extends StatefulWidget {
  const r1({Key? key}) : super(key: key);

  @override
  State<r1> createState() => _r1State();
}

class _r1State extends State<r1> {
  var flag=0;
  Future<dynamic> getdata() async {
    var response = await post(Uri.parse("${con.url}rent/rent.php"));
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 && jsonDecode(response.body)[0]['result']=='success') {
      flag=1;
      return jsonDecode(response.body);

    }
    else {
      flag=0;
      const CircularProgressIndicator();
      Text('no data');
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: SafeArea(
    child: Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios_new)),

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('GO Share',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff068DA9),
                  fontFamily: 'Times New Roman'
              ),),
            ),


            //app name
          ],
        ),

        Expanded(
          // height: ,
          // width: double.infinity,
          child: FutureBuilder(
          future: getdata(),
    builder: (context,snapshot) {
      if (snapshot.hasError) {
        print(snapshot.error);
      }
      // if (!snapshot.hasData ||snapshot.data.length==0) {
      // return const Center(
      // child: CircularProgressIndicator(),
      // );
      // }
      return flag == 0 ? Center(child: CircularProgressIndicator()) :
      ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              child: Container(
                  width: 350,
                  height: 350,
                  child: Column(
                    children: [
                      Image(image: AssetImage('assets/home/h (3).jpeg'),
                        fit: BoxFit.contain,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('${snapshot.data[index]['name']}', style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),),
                          Text('${snapshot.data[index]['mobile_no']}', style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),),

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('${snapshot.data[index]['vehicle_no']}', style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),),
                          // Text('4 Seats', style: TextStyle(
                          //     fontSize: 18, fontWeight: FontWeight.bold),),

                        ],
                      ),
                      Text('\$${snapshot.data[index]['price']}', style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),),
                      Text('${snapshot.data[index]['vehicle_model']}', style: TextStyle(fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent),),

                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, top: 5),
                        child: Container(
                          height: 59,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  backgroundColor: Color(0xff068DA9)),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                        r2(
                                            img: 'assets/home/h (3).jpeg',
                                            name: '${snapshot.data[index]['name']}',
                                            number: '${snapshot.data[index]['mobile_no']}',
                                            vehicle: '${snapshot.data[index]['vehicle_model']}',
                                            price: '${snapshot.data[index]['price']}',
                                            status: '${snapshot.data[index]['vehicle_no']}')));
                              },
                              child: Text(
                                'Book', style: TextStyle(fontSize: 20),)),
                        ),
                      ),

                    ],
                  )
              ),
            );
          }


      );
    })
    )
    ],
    )),
    );
  }
}
