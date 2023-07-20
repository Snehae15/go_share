import 'package:flutter/material.dart';

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children:[
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
            SizedBox(height: 30,),
            Container(
              height: 600,
              child: ListView.separated(itemBuilder: (context,index){
                return ListTile(
                  leading: Column(
                    children: [
                      Text('1${index} KM',style: TextStyle(fontSize: 20),),
                      Text('1${index}:00 ',style: TextStyle(fontSize: 20),),

                    ],
                  ),
                  title:Text('Calicut',style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman',fontWeight: FontWeight.bold),),
                  subtitle: Text('1${index}/01/2023'),
                  trailing: Text('Car',style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman',fontWeight: FontWeight.w400)),
                );
              }, separatorBuilder: (context,index){
                return Divider(
                  thickness: 3,
                );
              }, itemCount: 5),
            )
]

        ),
      ),
    );
  }
}
