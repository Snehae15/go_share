import 'package:corider/Car%20pooling/c4.dart';
import 'package:corider/Goods%20Movement/gm2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../connect.dart';
import 'gm4.dart';
class gm3 extends StatefulWidget {
  const gm3({Key? key}) : super(key: key);

  @override
  State<gm3> createState() => _gm3State();
}

class _gm3State extends State<gm3> {
  var pick;
  var time_pick;
  var select=TimeOfDay.now();
  var starting_pointctrl=TextEditingController();
  var destinationctrl=TextEditingController();
  var vehicle_noctrl=TextEditingController();
  var datectrl=TextEditingController();
  var timectrl=TextEditingController();
  GlobalKey<FormState> gtkey = GlobalKey<FormState>();
  
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
  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? login_id = prefs.getString('loginId');
    return login_id;
  }
  @override
  void initstate(){
    super.initState();
    getLoginId();
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
      'starting_point':starting_pointctrl.text,
      'destination':destinationctrl.text,
      'vehicle_no':vehicle_noctrl.text,
      'date':datectrl.text,
      'time':timectrl.text,
      'log_id':log_id
    };
    var response=await post(Uri.parse("${con.url}goods_movement/goods.php"),body: data);
    print(response.body);
    if (response.statusCode==200) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Goods movement added')));
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>gm2()),(Route <dynamic> route )=>false);
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: gtkey,
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
                Container(
                    height: 200,
                    child: Image(image: AssetImage('assets/login/gd3.png'),fit: BoxFit.contain,)),
                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
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
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
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
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
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
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
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
                  padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
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
                  padding: const EdgeInsets.only(left: 0.0,top: 20),
                  child: Container(
                    height: 60,
                    width: 100,
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
                          if (gtkey.currentState!.validate()) {
                            setState(() {
                              senddata();
                            });

                          }  
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>gm4()));
                        }, child: Text('Add',style: TextStyle(fontSize: 20),)),
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
