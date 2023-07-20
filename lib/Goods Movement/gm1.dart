import 'package:corider/Goods%20Movement/gm2.dart';
import 'package:corider/Goods%20Movement/gm3.dart';
import 'package:flutter/material.dart';
class gm1 extends StatelessWidget {
  const gm1({Key? key}) : super(key: key);

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
            Container(
                height: 264,
                width: 350,
                child: Image(image: AssetImage('assets/login/gd2.png'),fit: BoxFit.contain,)),

            SizedBox(
              height: 20,
            ),
            Container(
                height: 70,
                width: double.infinity,
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(color: Color(0xff068DA9)))),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>gm2()));
                      }, child: Text(
                    'Find Goods carrier',style: TextStyle(color: Color(0xff068DA9),fontWeight: FontWeight.bold,fontSize: 20),)),
                )),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 70,
                  width: double.infinity,
                  child:OutlinedButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(color: Color(0xff068DA9)))),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>gm3()));
                      }, child: Text(
                    'Offer Goods carrier',style: TextStyle(color: Color(0xff068DA9),fontWeight: FontWeight.bold,fontSize: 20),))),
            ),





          ],
        ),
      ),
    );
  }
}
