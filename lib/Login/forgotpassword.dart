import 'package:corider/Home/Home.dart';
import 'package:corider/Login/newpassword.dart';
import 'package:flutter/material.dart';
class forgot extends StatefulWidget {
  const forgot({Key? key}) : super(key: key);

  @override
  State<forgot> createState() => _forgotState();
}

class _forgotState extends State<forgot> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),//app name
                ],
              ),
              SizedBox(
                  height: 180
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text('Enter four digit  code sent to your email',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,fontFamily: 'Times New Roman'),),
              ),
              SizedBox(
                  height: 40
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 60,
                      child: TextField(
                        style: TextStyle(color: Colors.black,fontSize: 22),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffDCDADA),
                            hintText: '',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,

                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      child: TextField(
                        style: TextStyle(color: Colors.black,fontSize: 22),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffDCDADA),
                            hintText: '',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,

                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      child: TextField(
                        style: TextStyle(color: Colors.black,fontSize: 22),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffDCDADA),
                            hintText: '',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,

                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      child: TextField(
                        style: TextStyle(color: Colors.black,fontSize: 22),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffDCDADA),
                            hintText: '',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,

                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Stack(
                  children:[
                    Container(
                        height: 300,
                        width: 350,
                        child: Opacity
                          (
                            opacity: 0.4,
                            child: Image(image: AssetImage('assets/login/l.jpg'),fit: BoxFit.cover,))),
                    Padding(
                      padding: const EdgeInsets.only(left: 130.0,top: 50),
                      child: Container(
                        height: 45,
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>addpassword()));
                            }, child: Text('Verify')),
                      ),
                    ),

                  ]),

            ],
          ),
        ),
      ),
    );
  }
}
