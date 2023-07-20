import 'dart:convert';
import 'package:corider/Car%20pooling/c1.dart';
import 'package:corider/Home/Home.dart';
import 'package:corider/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../connect.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  var visible_password = true;
  var visible_confirmpassword = true;
  bool _isValid = true;
  var first_namectrl = TextEditingController();
  var last_namectrl = TextEditingController();
  var email = TextEditingController();
  var mobile_noctrl = TextEditingController();
  var passwordctrl = TextEditingController();
  var confirm_passwordctrl = TextEditingController();

  bool validateMobileNumber(String mobileNumber) {
    RegExp mobileRegex = RegExp(r'^[0-9]{10}$');
    return mobileRegex.hasMatch(mobileNumber);
  }

  bool validateEmail(String email) {
    // Use a regular expression to validate email format
    RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  final registerkey = GlobalKey<FormState>();

  Future<void> sentdata() async {
    var data = {
      'first_name': first_namectrl.text,
      'last_name': last_namectrl.text,
      'email': email.text,
      'mobile_no': mobile_noctrl.text,
      'password': passwordctrl.text,
    };
    var response = await post(Uri.parse("${con.url}login/insert.php"), body: data);
    print(response.body);
    if (jsonDecode(response.body)['result'] == 'success') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registered')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: registerkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'GO Share',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff068DA9),
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ), //app name
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Field required';
                      }
                      return null;
                    },
                    controller: first_namectrl,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffDCDADA),
                      hintText: 'First name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Field required';
                      }
                      return null;
                    },
                    controller: last_namectrl,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffDCDADA),
                      hintText: 'Last name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (!validateEmail(val!)) {
                        return 'Invalid Email id';
                      }
                      return null;
                    },
                    controller: email,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffDCDADA),
                      hintText: 'Email id',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(),
                    validator: (val) {
                      if (!validateMobileNumber(val!)) {
                        return 'Invalid mobile number';
                      }
                      return null;
                    },
                    controller: mobile_noctrl,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffDCDADA),
                      hintText: 'Mobile no',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (val) {
                      if (val!.length <= 6 && val.isEmpty) {
                        return 'Password required or too short';
                      }
                      return null;
                    },
                    obscureText: visible_password,
                    controller: passwordctrl,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visible_password = !visible_password;
                          });
                        },
                        icon: (visible_password)
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      filled: true,
                      fillColor: const Color(0xffDCDADA),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: confirm_passwordctrl,
                    obscureText: visible_confirmpassword,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visible_confirmpassword = !visible_confirmpassword;
                          });
                        },
                        icon: (visible_confirmpassword)
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility),
                      ),
                      filled: true,
                      fillColor: const Color(0xffDCDADA),
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 300,
                      width: 350,
                      child: const Opacity(
                        opacity: 0.4,
                        child: Image(image: AssetImage('assets/login/l.jpg'), fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 130.0, top: 50),
                      child: Container(
                        height: 45,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: const Color(0xff068DA9),
                          ),
                          onPressed: () {
                            print(first_namectrl.text);
                            print(last_namectrl.text);
                            print(mobile_noctrl.text);
                            print(passwordctrl.text);
                            if (registerkey.currentState!.validate()) {
                              if (passwordctrl.text == confirm_passwordctrl.text) {
                                sentdata();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('Password mismatch'),
                                ));
                              }
                            }
                          },
                          child: const Text('Next'),
                        ),
                      ),
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