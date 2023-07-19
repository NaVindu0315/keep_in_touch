import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

//void main() => runApp(gemifysign());
void main() {
  runApp(signup());
}

class signup extends StatefulWidget {
  static String id = 'signup';

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  ///declaring variables

  late String email;
  late String boy;
  late String girl;
  late String dob;
  late String pw;
  late String pw2;
  late String iurl;

  ///variales end
  ///
  ///function to set data to userfield
  Future<void> adduser(
    String email,
    String boy,
    String girl,
    String dob,

    ///meka cut krpn
    String thisurl,
  ) async {
    // await _firestore.collection('userdetails').add({'email': email, 'pw': pw});
    await FirebaseFirestore.instance.collection('users').doc(email).set({
      'email': email,
      'boyname': boy,
      'girlname': girl,
      'dob': dob,

      ///meka cut krpn
      'url': thisurl,
    });
  }

  ///creating users function begin
  void createuser() async {
    try {
      final newuser = await _auth.createUserWithEmailAndPassword(
          email: email, password: pw);

      ///call the add details function here
      adduser(email, boy, girl, dob, iurl);

      if (newuser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => login()),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  ///creating users end

  File? _image;
  Image myIcon = Image.asset('assets/ad.png');

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      ///meke tyyna hamahuttama kapapan
      final ref = storage.ref().child('images/${DateTime.now().toString()}');
      final uploadTask = ref.putFile(File(pickedImage.path));
      final snapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL();
      iurl = imageUrl;
      _image = File(pickedImage.path);

      setState(() {
        myIcon = Image.asset('pickedImage');
      });
    }
  }

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  late String _passwordError;

  void _validatePassword(pw2) {
    if (pw2 == pw) {
    } else {
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text("Password doesn't match."),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF19589D),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )),
          title: const Text('Lecturer Sign Up'),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 24),
            ),
          ],
        ),
        backgroundColor: Colors.blue.shade100,
        body: SingleChildScrollView(
          reverse: true,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => login()),
                            );
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
                                Navigator.pushNamed(context, signup.id);
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
                  SizedBox(
                    height: 20.0,
                  ),

                  ////for the image adding button
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 135.0,
                      ),
                      InkWell(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          radius: 50.0,
                          backgroundImage:
                              _image != null ? FileImage(_image!) : null,
                          child: /*Image(
                            image: AssetImage('images/ad.png'),
                          ),*/
                              _image == null
                                  ? Image.asset('assets/img2.png')
                                  : Image.file(_image!),

                          /*IconButton(
                              icon: myIcon,
                              onPressed: null,
                            ),*/
                        ),
                      )
                    ],
                  ),
                  ////image adding button end

                  //// sign up and login labels

                  ////sign up and login labels end
                  SizedBox(
                    height: 15.0,
                  ),

                  //email
                  TextFormField(
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
//mobile
                  TextFormField(
                    onChanged: (value) {
                      boy = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.boy,
                      ),
                      labelText: 'Boy Friends Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //address
                  TextFormField(
                    onChanged: (value) {
                      girl = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.girl,
                      ),
                      labelText: 'Girl Friends Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //birthday
                  TextFormField(
                    onChanged: (value) {
                      dob = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.calendar_today),
                      ),
                      labelText: 'Since ',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  //password
                  TextFormField(
                    controller: _passwordController,
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
                  //confirm Password
                  TextFormField(
                    controller: _confirmPasswordController,
                    onChanged: (value) {
                      pw2 = value;
                      //_validatePassword(value);
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.key,
                      ),
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //to add social media icons

                  SizedBox(
                    height: 32.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF19589D))),
                    onPressed: () {
                      if (pw == pw2) {
                        createuser();
                      } else {
                        _passwordController.clear();
                        _confirmPasswordController.clear();
                        AlertDialog alert = AlertDialog(
                          title: Text("Error"),
                          content: Text("Password doesn't match."),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      //adduser(username, email, mobile, address, dob);
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
