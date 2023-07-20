import 'package:corider/Login/login.dart';
import 'package:corider/Police%20module/police_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class police_login extends StatefulWidget {
  const police_login({super.key});

  @override
  State<police_login> createState() => _police_loginState();
}

class _police_loginState extends State<police_login> {
  var visible_password=true;
  var _mobilenoController = TextEditingController();
  var _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var code='police';
  var password='12345';
  void log(){
    if (_mobilenoController.text == code && _passwordController.text==password) {
      print(_mobilenoController);
      print(_passwordController);
      Navigator.push(context, MaterialPageRoute(builder: (context) => police_home()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login success')));

    }
    else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text('GO Share',style: GoogleFonts.gruppo(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff068DA9),
                          // fontFamily: 'Times New Roman'
                        ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text('POLICE',style: GoogleFonts.gruppo(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff068DA9),
                        // fontFamily: 'Times New Roman'
                      ),),
                    ),

                    Container(
                        height: 200,
                        width: 200,
                        child: Image(image: AssetImage('assets/login/p2.png'),fit: BoxFit.cover,)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' Enter code';
                          }
                          return null;
                        },
                        controller: _mobilenoController,
                        style: TextStyle(color: Colors.black,fontSize: 18),
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.person,color: Color(0xff068DA9),),
                            filled: true,
                            fillColor: Color(0xffDCDADA),
                            hintText: 'Enter code',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:0.0,horizontal: 18),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        style: TextStyle(color: Colors.black,fontSize: 18),
                        obscureText: visible_password,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: (){
                              setState(() {
                                visible_password=!visible_password;
                                print(visible_password);
                              });
                            }, icon:(visible_password)?Icon(Icons.visibility_off,color: Color(0xff068DA9),):Icon(Icons.visibility,color: Color(0xff068DA9),)),

                            filled: true,
                            fillColor: Color(0xffDCDADA),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: 220,
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
                              log();
                          }, child: Text('Login',style: TextStyle(fontSize: 20),)),
                    ),

                  ]),
            )



        ),
          ),


    );
  }
}
