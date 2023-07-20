import 'package:corider/Login/login.dart';
import 'package:corider/Police%20module/police_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class first_page extends StatelessWidget {
  const first_page({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(

                  ),
                    height:300,
                    width: 300,
                    child: Image(image: AssetImage('assets/login/logo.jpg'),fit: BoxFit.contain,)),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 300,
                  height: 70,
                  child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(color: Color(0xff068DA9))),

                      ),
                      onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                  }, child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.person,size: 35,color:  Color(0xff068DA9),),
                      Text('User',style: GoogleFonts.mukta(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff068DA9),
                        // fontFamily: 'Times New Roman'
                      ),),
                    ],
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 300,
                  height: 70,
                  child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(color: Color(0xff068DA9))),

                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>police_login()));
                      }, child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.local_police_outlined,size: 35,color:  Color(0xff068DA9),),
                      Text('Police',style: GoogleFonts.mukta(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff068DA9),
                        // fontFamily: 'Times New Roman'
                      ),),
                    ],
                  )),
                ),
              ),
            ],
          )),
    );
  }
}
