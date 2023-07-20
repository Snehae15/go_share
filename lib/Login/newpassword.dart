import 'package:corider/Home/Home.dart';
import 'package:corider/Home/h1.dart';
import 'package:flutter/material.dart';
class addpassword extends StatefulWidget {
  const addpassword({Key? key}) : super(key: key);

  @override
  State<addpassword> createState() => _addpasswordState();
}

class _addpasswordState extends State<addpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                ),
                //app name
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text('Reset password',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 30),
              child: TextField(
                style: TextStyle(color: Colors.black,fontSize: 18),
                obscureText: true,

                decoration: InputDecoration(

                    suffixIcon: Icon(Icons.remove_red_eye,color: Colors.black,),
                    filled: true,
                    fillColor: Color(0xffDCDADA),
                    hintText: ' New password',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,

                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:0.0,horizontal: 18),
              child: TextField(
                style: TextStyle(color: Colors.white,fontSize: 18),
                obscureText: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffDCDADA),
                    hintText: ' Confirm Password',
                    suffix: Icon(Icons.remove_red_eye),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
              ),
            ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                    }, child: Text('Confirm')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
