import 'package:flutter/material.dart';
class r2 extends StatefulWidget {
   r2({Key? key,required this.img,required this.name,
    required this.number,
    required this.vehicle,required this.price,
    required this.status,}) : super(key: key);
var img,name,status,seat,price,vehicle,number;
  @override
  State<r2> createState() => _r2State();
}

class _r2State extends State<r2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
        IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        backgroundColor: Colors.white,
        actions: [

          Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 15),
            child: Text('GO Share',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xff068DA9),
                fontFamily: 'Times New Roman'
            ),),
          ),

        ],
      ),
        body: SafeArea(
          child: Center(
            child: Card(
              elevation: 10,
              child:Container(
                height: 400,
                width: 350,
                child: Column(
                  children: [
                    Image(image: AssetImage('${widget.img}')),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('   ${widget.name}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                          Text('${widget.number}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('${widget.vehicle}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                          Text('${widget.seat}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('   \$${widget.price} /day',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.red),),
                          Text('${widget.status}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.greenAccent),),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0,top: 15),
                      child: Container(
                        height: 60,
                        width: 150,
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

                            }, child: Text('Contact',style: TextStyle(fontSize: 20),)),
                      ),
                    ),






                  ],
                ),
              ) ,
            ),
          ),
        ),
    );
  }
}
