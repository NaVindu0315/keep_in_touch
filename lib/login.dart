import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_touch/dashboard.dart';
import 'package:keep_in_touch/signup.dart';

import 'main.dart';

import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(login());
}

class login extends StatefulWidget {
  static String id = 'loginscreen';

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController pwcontroller = TextEditingController();

  final _auth = FirebaseAuth.instance;
  late String email;
  late String pw;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          backgroundColor: Color(0xFF19589D),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )),
          title: const Text('Lecturer Login'),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 24),
            ),
          ],
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  /*Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Image.asset('images/login.png'),
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 50),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF19589D),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, login.id);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF19589D),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => signup()),
                                );
                              },
                              child: Text(
                                'SIGNUP',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      'The LMS', // Add this new Text widget
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5), // Add this SizedBox widget
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80),
                    child: Text(
                      'Sign in to your account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    height: 70,
                    width: 350, // Set the width of the SizedBox to 300 pixels
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: emailcontroller,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 70,
                    width: 350, // Set the width of the SizedBox to 300 pixels
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: pwcontroller,
                        onChanged: (value) {
                          pw = value;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.key,
                          ),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "New Lecturer ? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => signup()),
                            );
                            // Add your sign up button onPressed code here
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF19589D),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              //decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          " Now ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 350,
                      height: 50,
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      child: ElevatedButton(
                        onPressed: () async {
                          emailcontroller.clear();
                          pwcontroller.clear();
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: pw);

                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => lec_dashboard()),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF19589D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //to add social media icons
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
