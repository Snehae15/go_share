import 'dart:convert';

import 'package:corider/Home/Home.dart';
import 'package:corider/Login/forgotpassword.dart';
import 'package:corider/Login/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../connect.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var visible_password = true;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void savedata(String logId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginId', logId); // Use 'loginId' as the key
  }
  Future<void> loginUser() async {
    var data = {
      'email': _emailController.text,
      'password': _passwordController.text
    };
    var response = await http.post(Uri.parse("${con.url}login/login.php"), body: data);
    print(response.body);

    try {
      var responseBody = jsonDecode(response.body);
      if (responseBody['result'] == 'Login success') {
        // Store the login_id in SharedPreferences
        savedata(responseBody['log_id']);
        Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login success')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
      }
    } catch (e) {
      print('Error decoding JSON: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred during login')));
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
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      'GO Share',
                      style: GoogleFonts.gruppo(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff068DA9),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image(
                      image: AssetImage('assets/login/a.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email id';
                      }
                      return null;
                    },
                    controller: _emailController,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.person, color: Color(0xff068DA9)),
                      filled: true,
                      fillColor: Color(0xffDCDADA),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 18),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    obscureText: visible_password,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visible_password = !visible_password;
                            print(visible_password);
                          });
                        },
                        icon: (visible_password)
                            ? Icon(Icons.visibility_off, color: Color(0xff068DA9))
                            : Icon(Icons.visibility, color: Color(0xff068DA9)),
                      ),
                      filled: true,
                      fillColor: Color(0xffDCDADA),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 50,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Color(0xff068DA9),
                      ),
                      onPressed: loginUser,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont have an Account? '),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => register()),
                        );
                      },
                      child: Text('Signup'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
