import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home/Home.dart';
import '../connect.dart';
class review extends StatefulWidget {
  const review({Key? key}) : super(key: key);

  @override
  State<review> createState() => _reviewState();
}

class _reviewState extends State<review> {
  var select=false;
  var reviewctrl=TextEditingController();
  double rating=0;
  var date=DateTime.now();
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
      'review':reviewctrl.text,
      'date':date.toString(),
      'log_id':log_id,
      'rating':rating.toString()
    };
    print(data);
    var response=await post(Uri.parse("${con.url}review/review.php"),body: data);
    print(response.body);
    if (response.statusCode==200) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('review registerd')));
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>home()),(Route <dynamic> route )=>false);
    }
  }
final reviewkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key:reviewkey,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (val){
                        if (val==null) {
                          return 'Reqired';
                        }
                      },
                      controller: reviewctrl,
                      style: TextStyle(color: Colors.black,fontSize: 20),
                      maxLines: 10,
                      decoration: InputDecoration(
                          fillColor: Colors.black12,
                          filled: true,
                          hintText: 'Enter your review here......',
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      for(int i=1;i<=5;i++)
                        InkWell(
                          onTap: (){
                            setState(() {
                              rating=i.toDouble();
                            });
                          },
                          child: Icon(i<=rating?Icons.star:Icons.star_border,size: 40,color: Colors.amber,
                        ))
                    ],
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
                          if (reviewkey.currentState!.validate()) {
                            print('success');
                            register();
                          }  
                        }, child:Text('Register',style: TextStyle(color: Color(0xff068DA9),
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
