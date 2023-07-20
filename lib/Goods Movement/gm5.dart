import 'package:flutter/material.dart';
class gm5 extends StatefulWidget {
  const gm5({Key? key}) : super(key: key);

  @override
  State<gm5> createState() => _gm5State();
}

class _gm5State extends State<gm5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context,index){
                      return  Card(
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
                                        Text('Calicut',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                        Text('Cochin',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

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
                      )
                      ;
                    }),
              )

            ],
          ),
        ),
      ),
    );
  }
}
