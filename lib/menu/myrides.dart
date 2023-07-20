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
    var response = await post(Uri.parse("${con.url}my_rides/read.php"));
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
  void initState(){
    super.initState();
    getdata();
  }
  Future <dynamic> deletedata() async{
    print(ride_id);
    var data={'ride_id':ride_id.toString()};
    // var response=await post(Uri.parse("${con.utl}delete.php"),body:data);
    var response=await post(Uri.parse("${con.url}my_rides/delete.php"),body: data);
    if (jsonDecode(response.body)['result']=='Success') {
      return jsonDecode(response.body);
    }
    else
    {
      const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>addride()));
      }, icon: Icon(Icons.add))

      //app name
      ],
    ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder(
                      future: getdata(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        return flag==0?
                        Center(child: CircularProgressIndicator()):
                         ListView.separated(
                            itemBuilder: (context,index){
                              print(snapshot.data.length);
                          return ListTile(
                            leading: Column(
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(height: 5,),
                                Text('${snapshot.data[index]['time']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                              ],
                            ),
                            title:Text('${snapshot.data[index]['destination']}',style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman',fontWeight: FontWeight.bold),),
                            subtitle: Text('${snapshot.data[index]['date']}'),
                           trailing:IconButton(onPressed: (){
                             ride_id=snapshot.data[index]['ride'];
                             setState(() {
                               deletedata();

                             });
                           }, icon: Icon(Icons.delete_outline))
                          );
                        }, separatorBuilder: (context,index){
                          return Divider(
                            thickness: 3,
                          );
                        }, itemCount: snapshot.data.length);
                      }
                    ),
                  ),
  ]
            ),
          ),
        ),
    );
  }
}
