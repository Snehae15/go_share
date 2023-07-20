import 'package:corider/Car%20pooling/c1.dart';
import 'package:corider/Car%20pooling/c4.dart';
import 'package:corider/Car%20pooling/connect_location.dart';
import 'package:corider/Goods%20Movement/gm4.dart';
import 'package:corider/Group%20trip/gt4.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class gt5 extends StatefulWidget {
  gt5({Key? key,required this.group_name,required this.starting_point,required this.destination,required this.gt_id,required this.date,required this.vehicle_no,required this.vehicle_type}) : super(key: key);
  var starting_point,destination,date,vehicle_no,gt_id,vehicle_type,group_name;
  @override
  State<gt5> createState() => _gt5State();
}

class _gt5State extends State<gt5> {
  var starting_pointctrl=TextEditingController();
  var destinationctrl=TextEditingController();
  var vehicle_noctrl=TextEditingController();
  var datectrl=TextEditingController();
  var group_namectrl=TextEditingController();
  var vehicle_typectrl=TextEditingController();
  var first_name;
  var last_name;
  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? login_id = prefs.getString('loginId');
    return login_id;
  }
  @override
  void initState(){
    super.initState();
    starting_pointctrl.text=widget.starting_point;
    destinationctrl.text=widget.destination;
    group_namectrl.text=widget.group_name;
    datectrl.text=widget.date;
    vehicle_noctrl.text=widget.vehicle_no;
    vehicle_typectrl.text=widget.vehicle_type;
    print(widget.gt_id);
    print(starting_pointctrl.text);
    print(destinationctrl.text);
    print(group_namectrl.text);
    print(vehicle_noctrl.text);
    print(vehicle_typectrl.text);
    getLoginId();
  }

  // Future<Map<String?,String?>> getData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? log_Id = prefs.getString('log_id');
  //   String? first_name = prefs.getString('first_name');
  //   String? last_name = prefs.getString('last_name');
  //   String? mobile_no = prefs.getString('mobile_no');
  //   return {
  //     'log_id': log_Id,
  //     'first_name': first_name,
  //     'last_name': last_name,
  //     'mobile_no': mobile_no
  //   };
  // }

  // void profile(first_name,last_name,log_id,mobile_no) async{
  //     Map<String?,String?>data=await getData();
  //     String? first_name=data['first_name'];
  //     String? last_name=data['last_name'];
  //     String? log_id=data['log_id'];
  //     String? mobile_no=data['mobile_no'];
  //
  // }
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

  final tripkey=GlobalKey<FormState>();

  Future<void> senddata()  async {
    var log_id=await getLoginId();
    var userData=await getData();
    first_name=userData['first_name'];
    last_name=userData['last_name'];
    // mobile_no=userData['mobile_no'];
    if (log_id!=null && first_name!=null && last_name!=null) {
      print("log_id:$log_id");
      print("first_name:$first_name");
      print("last_name:$last_name");
      // print("mobile_no:$mobile_no");
    }
    else
    {
      print('error');

    }
    var data={
      // 'mobile_no':mobile_no,
      'starting_point':starting_pointctrl.text,
      'destination':destinationctrl.text,
      'vehicle_no':vehicle_noctrl.text,
      'vehicle_type':vehicle_typectrl.text,
      'group_name':group_namectrl.text,
      'date':datectrl.text,
      'log_id':log_id,
      'gt_id':widget.gt_id
    };
    var response=await post(Uri.parse("${con.url}group_trip/update.php"),body: data);
    print(response.body);
    if (response.statusCode==200) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Group trip Updated')));
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>gt4()),(Route <dynamic> route )=>false);
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
                // CircleAvatar(
                //   backgroundColor: Colors.grey,
                //   radius: 50,
                //   child: Center(child: IconButton(onPressed: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>c4()));
                //   }, icon: Icon(Icons.add,size: 35,color: Colors.white70,))),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                  child: TextFormField(
                    validator: (val){
                      if ( val!.isEmpty){
                        return 'Field reqired';
                      }
                    },
                    controller: starting_pointctrl,
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
                Padding(
                  padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                  child: TextFormField(
                    validator: (val){
                      if ( val!.isEmpty){
                        return 'Field reqired';
                      }
                    },
                    controller: destinationctrl,
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
                Padding(
                  padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                  child: TextFormField(
                    validator: (val){
                      if ( val!.isEmpty){
                        return 'Field reqired';
                      }
                    },
                    controller: vehicle_noctrl,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffDCDADA),
                        hintText: 'Vehicle number',
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
                    controller: vehicle_typectrl,

                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffDCDADA),
                        hintText: 'Vehicle_type',
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
                  padding: const EdgeInsets.only(left: 0.0,top: 30),
                  child: Container(
                    height: 60,
                    width: 120,
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
                            senddata();

                          }
                        }, child: Text('Update',style: TextStyle(fontSize: 20),)),
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
