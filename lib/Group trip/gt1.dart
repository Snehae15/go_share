import 'package:corider/Group%20trip/gt2.dart';
import 'package:corider/Group%20trip/gt3.dart';
import 'package:flutter/material.dart';
class gt1 extends StatelessWidget {
  const gt1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            SizedBox(
              height: 20,
            ),
            Container(
                height: 280,
                width: 350,
                child: Image(image: AssetImage('assets/login/gt.png'),fit: BoxFit.contain,)),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 60,
                  width: double.infinity,
                  child: OutlinedButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(color: Color(0xff068DA9)))),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>gt2()));

                      }, child: Text(
                    'Find group trip',style: TextStyle(color:  Color(0xff068DA9),fontWeight: FontWeight.bold,fontSize: 20),))),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 60,
                  width: double.infinity,
                  child: OutlinedButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(color: Color(0xff068DA9)))),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>gt3()));

                      }, child: Text(
                    'Create group trip',style: TextStyle(color: Color(0xff068DA9),fontWeight: FontWeight.bold,fontSize: 20),))),
            ),


          ],

        ),
      ),
    );
  }
}
