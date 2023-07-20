import 'package:flutter/material.dart';
class help extends StatelessWidget {
  const help({Key? key}) : super(key: key);

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
            SizedBox(height: 20,),
            Container(
              height: 600,
              child: ListView.separated(
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: Icon(Icons.local_police_outlined),
                      title: Text('Police',style: TextStyle(fontSize: 20),),
                      subtitle: Text('9947977759',style: TextStyle(fontSize: 22),),
                      trailing: Icon(Icons.call,color: Color(0xff068DA9),),
                    ) ;
                  }, separatorBuilder: (contex,index){
                    return Divider();
              },
                  itemCount: 4),
            )

          ],
        ),
      ),
    );
  }
}
