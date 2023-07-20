import 'package:flutter/material.dart';
class gt_detail extends StatefulWidget {
  gt_detail({Key? key,required this.starting_point,
    required this.first_name,required this.last_name,
    required this.mobile_no,required this.vehicle_type,
    required this.group_name,required this.destination,
    required this.vehicle_no,required this.date}) : super(key: key);
  var starting_point,destination,vehicle_no,date,first_name,last_name,
      vehicle_type,group_name,mobile_no;
  @override
  State<gt_detail> createState() => _gt_detailState();
}

class _gt_detailState extends State<gt_detail> {
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
                        height: 400,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.group_name.toUpperCase(),style: TextStyle(fontSize: 30,fontFamily: 'Times New Roman',fontWeight: FontWeight.bold,color: Colors.teal),),
                            SizedBox(height: 10,),

                            Text(widget.starting_point.toUpperCase(),style: TextStyle(fontSize: 27,fontFamily: 'Times New Roman',fontWeight: FontWeight.bold,color: Colors.teal),),
                            Text("to",style: TextStyle(fontSize: 30,fontFamily: 'Times New Roman',fontWeight: FontWeight.bold,color: Colors.black12),),
                            Text(widget.destination.toUpperCase(),style: TextStyle(fontSize: 27,fontFamily: 'Times New Roman',fontWeight: FontWeight.bold,color: Colors.teal)),
                            SizedBox(height: 10,),
                            SizedBox(height: 10,),

                            Text(widget.vehicle_no.toUpperCase(),style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman',fontWeight: FontWeight.w500,color: Colors.black38)),
                            SizedBox(height: 10,),

                            Text(widget.vehicle_type.toUpperCase(),style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman',fontWeight: FontWeight.w500,color: Colors.black38)),

                            SizedBox(height: 10,),

                            Text(widget.date,style: TextStyle(fontSize: 25,fontFamily: 'Times New Roman',fontWeight: FontWeight.w500,color: Colors.black45)),
                            SizedBox(height: 10,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.first_name.toUpperCase(),style: TextStyle(fontSize: 18,fontFamily: 'Times New Roman',fontWeight: FontWeight.w500,color: Colors.black45)),
                                SizedBox(width: 10,),

                                Text(widget.last_name.toUpperCase(),style: TextStyle(fontSize: 18,fontFamily: 'Times New Roman',fontWeight: FontWeight.w500,color: Colors.black45)),

                              ],

                            ),
                            SizedBox(height: 10,),

                            Text(widget.mobile_no,style: TextStyle(fontSize: 18,fontFamily: 'Times New Roman',fontWeight: FontWeight.w500,color: Colors.black45)),


                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: (){}, child: Text('Contact'),),

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
