import 'package:corider/Home/h4.dart';
import 'package:corider/Login/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../connect.dart';
class h4edit extends StatefulWidget {
   h4edit({Key? key,required this.first_name,required this.last_name,required this.username,required this.email,required this.register_id,required this.dp}) : super(key: key);
  var first_name,last_name,username,email,log_id,register_id,dp;
  @override
  State<h4edit> createState() => _h4editState();

}

class _h4editState extends State<h4edit> {
  var first_namectrl=TextEditingController();
  var last_namectrl=TextEditingController();
  var usernamectrl=TextEditingController();
  var emailctrl=TextEditingController();
  var dpctrl=TextEditingController();
  var regctrl=TextEditingController();
  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? login_id = prefs.getString('loginId');
    return login_id;
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
  final registerkey=GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    first_namectrl.text=widget.first_name;
    last_namectrl.text=widget.last_name;
    usernamectrl.text=widget.username;
    emailctrl.text=widget.email;
    dpctrl.text=widget.dp;
    regctrl.text=widget.register_id;
    print(widget.register_id);
    getLoginId();
    print("first_name:${widget.first_name}");
    print("last_name:${widget.last_name}");
    print("username:${widget.username}");
    print("email:${widget.email}");
    print("dp:${widget.dp}");
    print("register:${widget.register_id}");
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
      'first_name':first_namectrl.text,
      'last_name':last_namectrl.text,
      'username':usernamectrl.text,
      'email':emailctrl.text,
      'dp':dpctrl.text,
      'log_id':log_id,
      'register_id':widget.register_id
    };
    print(log_id);
    print(widget.register_id);

    // print("dp:${widget.dp}");

    var response=await post(Uri.parse("${con.url}login/update.php"),body: data);
    print(response.body);
    if (response.statusCode==200) {
      print("first_name:${widget.first_name}");
      print("last_name:${widget.last_name}");
      print("username:${widget.username}");
      print("email:${widget.email}");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated')));
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>h4()),(Route <dynamic> route )=>false);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading:IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new),color: Colors.black,),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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

        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: registerkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Edit Profile')),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage('${con.url}login/image/${widget.dp}'),
                    radius: 100,
                  ),
    SizedBox(height: 35,),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0,left:10,right: 10),
                    child: TextFormField(
                      validator: (val){
                        if ( val!.isEmpty){
                          return 'Field reqired';
                        }
                      },
                      controller: first_namectrl,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffDCDADA),
                          hintText: 'First_name',
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
                      controller: last_namectrl,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffDCDADA),
                          hintText: 'Last name',
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
                      controller: usernamectrl,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffDCDADA),
                          hintText: 'username',
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
                      controller: emailctrl,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffDCDADA),
                          hintText: 'email',
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
                            if (registerkey.currentState!.validate())
                            {
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registerd')));

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
      ),
    );
  }
}
