import 'package:corider/menu/myrides.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../connect.dart';
class addride extends StatefulWidget {
  const addride({Key? key}) : super(key: key);

  @override
  State<addride> createState() => _addrideState();
}

class _addrideState extends State<addride> {
  var pick;
  var time_pick;
  var select=TimeOfDay.now();
  var destinationctrl=TextEditingController();
  var datectrl=TextEditingController();
  var timectrl=TextEditingController();

  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? login_id = prefs.getString('loginId');
    return login_id;
  }
  Future<void> senddata()  async {
    var log_id=await getLoginId();
    if (log_id!=null) {
      print("log_id:$log_id");
    }
    else
    {
      print('error');

    }
    var data={
      'destination':destinationctrl.text,
      'date':datectrl.text,
      'time':timectrl.text,
      'log_id':log_id
    };
    var response=await post(Uri.parse("${con.url}my_rides/insert.php"),body: data);
    print(response.body);
    if (response.statusCode==200) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ride Added')));
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>myrides()),(Route <dynamic> route )=>false);
    }

  }
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
  Future<void> select_time() async {
    final TimeOfDay?time_pick=await
    showTimePicker(
        context: context, initialTime: select);
    if (time_pick!=null && time_pick!=select) {
      print(time_pick);
      String formattedtime=time_pick.format(context);
      print(formattedtime);
      setState(() {
        // timectrl=time_pick;
        select=time_pick;
        timectrl.text=formattedtime ;

      });
    }
  }
  void initState(){
    super.initState();
    print(select);
    getLoginId();

  }
  final ride_key=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
            key: ride_key,
            child: Column(
                children:[
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
                  SizedBox(height: 50,),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 15),
                  //   child: TextField(
                  //     style: TextStyle(color: Colors.black,fontSize: 18),

                  //   ),
                  // ),
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
                          suffixIcon: Icon(Icons.travel_explore_sharp,color: Color(0xff068DA9),),
                          filled: true,
                          fillColor: Color(0xffDCDADA),
                          hintText: 'Destination',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,

                              borderRadius: BorderRadius.circular(20)
                          )
                      ),                  ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                    child: TextFormField(
                      validator: (val){
                        if ( val!.isEmpty){
                          return 'Field reqired';
                        }
                      },
                      controller: timectrl,
                      onTap: (){

                        select_time();


                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffDCDADA),
                          hintText: 'Time  (9:00 am)',
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
                  SizedBox(height: 20,),
                  Container(
                      height: 60,
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff068DA9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),

                            )
                        ),
                        onPressed: (){
                      senddata();
                        },  child: Text('Add Ride',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),)


    ))]),
          )
    )
    );
  }
}
