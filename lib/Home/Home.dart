import 'package:corider/Home/h1.dart';
import 'package:corider/Home/h2.dart';
import 'package:corider/Login/login.dart';
import 'package:corider/Login/register.dart';
import 'package:flutter/material.dart';

import 'h4.dart';
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int current_index=0;
  List travel=[
    h1(),
    h2(),
    register(),
    h4(),

  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: travel[current_index],
      bottomNavigationBar:BottomNavigationBar(
        backgroundColor: Color(0xff068DA9),
        selectedItemColor: Color(0xff068DA9),
        unselectedItemColor: Colors.black,
        unselectedIconTheme: IconThemeData(color: Colors.black),
        selectedIconTheme: IconThemeData(color: Color(0xff068DA9)),
        currentIndex:current_index,
        onTap: (index){
          setState(() {
            current_index=index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,size: 32,),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded,size: 32),label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.messenger_outline,size: 32),label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person_sharp,size: 32),label: 'Profile'),





        ],),

    );
  }
}
