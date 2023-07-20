import 'package:corider/Car%20pooling/c4.dart';
import 'package:corider/Group%20trip/gt4.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../connect.dart';
import 'gt2.dart';

class gt3 extends StatefulWidget {
  const gt3({Key? key}) : super(key: key);

  @override
  State<gt3> createState() => _gt3State();
}

class _gt3State extends State<gt3> {
  var starting_pointctrl=TextEditingController();
  var destinationctrl=TextEditingController();
  var vehicle_noctrl=TextEditingController();
  var datectrl=TextEditingController();
  var group_namectrl=TextEditingController();
  var vehicle_typectrl=TextEditingController();
  var first_name;
  var last_name;
  var mobile_no;
  final tripkey=GlobalKey<FormState>();
  Future<void> select_date() async {
    final DateTime? pick= await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (pick!=null && pick!=select_date) {
      print(pick);
      String formatteddate=DateFormat('yyyy-MM-dd').format(pick);
      print(formatteddate);
      datectrl.text=formatteddate ;

      setState(() {
        datectrl.text=formatteddate ;
      });
    }
  }
  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? login_id = prefs.getString('loginId');
    return login_id;
  }
  Future<Map<String?,String?>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? log_Id = prefs.getString('log_id');
    String? first_name = prefs.getString('first_name');
    String? last_name = prefs.getString('last_name');
    String? mobile_no = prefs.getString('mobile_no');
    return {
      'log_id': log_Id,
      'first_name': first_name,
      'last_name': last_name,
      'mobile_no': mobile_no
    };
  }

  @override
  void initstate(){
    super.initState();
    getLoginId();
  }
  Future<void> senddata()  async {
    var log_id=await getLoginId();
    var userData=await getData();
     first_name=userData['first_name'];
     last_name=userData['last_name'];
     mobile_no=userData['mobile_no'];
    if (log_id!=null && first_name!=null && last_name!=null && mobile_no!=null) {
      print("log_id:$log_id");
      print("first_name:$first_name");
      print("last_name:$last_name");
      print("mobile_no:$mobile_no");
    }
    else
    {
      print('error');

    }
    var data={
      'first_name':first_name,
      'last_name':last_name,
      'mobile_no':mobile_no,
      'starting_point':starting_pointctrl.text,
      'destination':destinationctrl.text,
      'vehicle_no':vehicle_noctrl.text,
      'vehicle_type':vehicle_typectrl.text,
      'group_name':group_namectrl.text,
      'date':datectrl.text,
      'log_id':log_id
    };
    var response=await post(Uri.parse("${con.url}group_trip/insert.php"),body: data);
    print(response.body);
    if (response.statusCode==200) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Group trip created')));
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>gt2()),(Route <dynamic> route )=>false);
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: tripkey,
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
                SizedBox(height: 30,),

                Text('Create your trip'.toUpperCase(),style:
                TextStyle(
                    fontSize: 25,
                    color: Color(0xff068DA9),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Times New Roman'),),
                SizedBox(height: 30,),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                //       child: SizedBox(
                //         width: 170,
                //         child: TextField(
                //           style: TextStyle(color: Colors.black),
                //           decoration: InputDecoration(
                //               filled: true,
                //               fillColor: Color(0xffDCDADA),
                //               hintText: 'Name',
                //               border: OutlineInputBorder(
                //                   borderSide: BorderSide.none,
                //
                //                   borderRadius: BorderRadius.circular(20)
                //               )
                //           ),
                //         ),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                //       child: SizedBox(
                //         width: 170,
                //         child: TextField(
                //           style: TextStyle(color: Colors.black),
                //           decoration: InputDecoration(
                //               filled: true,
                //               fillColor: Color(0xffDCDADA),
                //               hintText: 'Mobile No',
                //               border: OutlineInputBorder(
                //                   borderSide: BorderSide.none,
                //
                //                   borderRadius: BorderRadius.circular(20)
                //               )
                //           ),
                //         ),
                //       ),
                //     ),
                //
                //   ],
                // ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                      child: SizedBox(
                        width: 170,
                        child: TextFormField(
                          controller: starting_pointctrl,
                          validator: (val){
                      if ( val!.isEmpty){
                      return 'Field reqired';
                      }
                      },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffDCDADA),
                              hintText: 'Starting point',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                      child: SizedBox(
                        width: 170,
                        child: TextFormField(
                          controller: destinationctrl,
                            validator: (val){
                              if ( val!.isEmpty){
                                return 'Field reqired';
                              }
                            },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffDCDADA),
                              hintText: 'Destination',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,

                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                      child: SizedBox(
                        width: 170,
                        child: TextFormField(
                          controller: vehicle_noctrl,
                          validator: (val){
                            if ( val!.isEmpty){
                              return 'Field reqired';
                            }
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffDCDADA),
                              hintText: ' Vehicle number',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,

                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                      child: SizedBox(
                        width: 170,
                        child:TextFormField(
                          controller: vehicle_typectrl,
                          validator: (val){
                            if ( val!.isEmpty){
                              return 'Field reqired'
                                  'eg:Xuv,Sedan etc';
                            }
                          },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffDCDADA),
                              hintText: 'Vehicle_type (xuv...',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,

                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                  child: TextFormField(
                    controller: group_namectrl,
                    validator: (val){
                      if ( val!.isEmpty){
                        return 'Field reqired';
                      }
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffDCDADA),
                        hintText: 'Group name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                  child: TextFormField(
                    validator: (val){
                      if ( val!.isEmpty){
                        return 'Field reqired';
                      }
                    },
                    controller: datectrl,
                    onTap: (){
                      setState(() {
                        select_date();

                      });
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffDCDADA),
                        hintText: 'Date   (1/10/2023)',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,

                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0,top: 50),
                  child: Container(
                    height: 60,
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
                        onPressed: (){
                          if (tripkey.currentState!.validate())
                          {
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registerd')));
                            senddata();

                          }
                        }, child: Text('Create',style: TextStyle(fontSize: 20),)),
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
