import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class offerpool extends StatefulWidget {
   offerpool({Key? key,required this.starting_point,required this.destination,required this.vehicle_no,required this.time,required this.date}) : super(key: key);
var starting_point,destination,vehicle_no,time,date;
  @override
  State<offerpool> createState() => _offerpoolState();
}

class _offerpoolState extends State<offerpool> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(

            child: Column(
              children: [
                Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new)),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'GO Share',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff068DA9),
                        fontFamily: 'Times New Roman'),
                  ),
                ),

                //app name
          ],
        ),


SizedBox(
  height: 50,
),

           Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Text(widget.time,style: TextStyle(fontSize: 25,fontFamily: 'Times New Roman',fontWeight: FontWeight.w500,color: Colors.black45)),
                        //     Text(widget.date,style: TextStyle(fontSize: 25,fontFamily: 'Times New Roman',fontWeight: FontWeight.w500,color: Colors.black45)),
                        //     ElevatedButton(
                        //       style: ElevatedButton.styleFrom(
                        //         backgroundColor: Colors.red,
                        //       ),
                        //       onPressed: (){}, child: Text('Contact'),)
                        //   ],
                        // ),

                        Text(widget.starting_point,style: TextStyle(fontSize: 30,fontFamily: 'Times New Roman',fontWeight: FontWeight.bold,color: Colors.teal),),
                        Text("to",style: TextStyle(fontSize: 30,fontFamily: 'Times New Roman',fontWeight: FontWeight.bold,color: Colors.black12),),
                        Text(widget.destination,style: TextStyle(fontSize: 30,fontFamily: 'Times New Roman',fontWeight: FontWeight.bold,color: Colors.teal)),
                        SizedBox(height: 10,),
                        SizedBox(height: 10,),

                        Text(widget.vehicle_no,style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman',fontWeight: FontWeight.w500,color: Colors.black38)),
                        SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(widget.time,style: TextStyle(fontSize: 25,fontFamily: 'Times New Roman',fontWeight: FontWeight.w500,color: Colors.black45)),
                            Text(widget.date,style: TextStyle(fontSize: 25,fontFamily: 'Times New Roman',fontWeight: FontWeight.w500,color: Colors.black45)),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                                onPressed: (){}, child: Text('Contact'),)
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            )
    ]
    )

    ),
    );
  }
}
