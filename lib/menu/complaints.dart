import 'dart:convert';
import 'package:intl/intl.dart';

import '../Home/Home.dart';
import '../connect.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
class complaints extends StatefulWidget {
  const complaints({Key? key}) : super(key: key);

  @override
  State<complaints> createState() => _complaintsState();
}

class _complaintsState extends State<complaints> {
  String formatTime(DateTime time) {
    DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(time);
  }

  void main() {
    DateTime currentTime = DateTime.now();
    String formattedTime = formatTime(currentTime);
    print(formattedTime); // Output: 3:30 PM
  }
  var date=DateTime.now();
  var complaintController = TextEditingController();
  var log_id;
  final complaintkey=GlobalKey<FormState>();

  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? log_id = prefs.getString('loginId');
    return log_id;
  }
  @override
  void initState(){
    super.initState();
    getLoginId();
  }
  Future<void> register()  async {
    var log_id=await getLoginId();
    if (log_id!=null) {
      print("log_id:$log_id");
    }
    else
    {
      print('error');

    }
    var data={
      'complaint':complaintController.text,
      'date':date.toString(),
      'time':formatTime(DateTime.now()),
      'log_id':log_id
    };
    print(data);
    var response=await post(Uri.parse("${con.url}complaints/complaints.php"),body: data);
    print(response.body);
    if (response.statusCode==200) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Complaint registerd')));
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>home()),(Route <dynamic> route )=>false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: complaintkey,
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
                SizedBox(height: 80,),

                SizedBox(
                  width: 340,
                  child: TextFormField(
                    validator: (val){
                      if ( val!.isEmpty){
                        return 'Field reqired';
                      }
                    },
                    controller: complaintController,
                    style: TextStyle(color: Colors.black45,fontSize: 20),
                    maxLines: 10,
                    decoration: InputDecoration(
                      fillColor: Colors.black12,
                      filled: true,
                      hintText: 'Register your complaints here......',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none
                      )
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 50,
                  width: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70
                      ),
                      onPressed: (){
                        if (complaintkey.currentState!.validate()) {
                          register();

                        }
                      }, child:Text(
                    'Register',style: TextStyle(color: Color(0xff068DA9),
    ),
                  ) ),
                ),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
