import 'package:corider/Car%20pooling/c6.dart';
import 'package:flutter/material.dart';
class c5 extends StatefulWidget {
  const c5({Key? key}) : super(key: key);

  @override
  State<c5> createState() => _c5State();
}

class _c5State extends State<c5> {
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
                Expanded(
                  // height: 580,
                  child: ListView.builder(
                    itemCount: 3,
                      itemBuilder: (context,index){
                      return  InkWell(
                    onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>c6(
                        img: 'assets/home/h (3).jpeg',
                        starting: 'starting',
                        destination: 'destination',
                        seat: ' 4 seat',
                        vehicle: 'mustang',
                        time: '6:00am',
                        date: '22/2/2023',
                        number: 'kl53e7515',
                        mobile: '9947977759')));},
                        child: Card(
                          elevation: 10,
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Container(
                                  width: 350,
                                  height: 300,
                                  child: Column(
                                    children: [
                                      Image(image:  AssetImage('assets/home/h (3).jpeg'),fit: BoxFit.contain,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('Calicut - Cochin ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                                        ],
                                      ),

                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('KL53E7515',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                          Text('4 Seats',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('9:00 Am',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                          Text('21/02/2023',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                                        ],
                                      ),

                                    ],
                                  )
                              )
                            ],
                          ),
                        ),
                      )
                      ;
                      }),
                )

              ],
            ),
          ),
    );
  }
}
