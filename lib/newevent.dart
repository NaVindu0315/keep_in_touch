import 'package:flutter/material.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() {}

class newevent extends StatefulWidget {
  @override
  State<newevent> createState() => _neweventState();
}

class _neweventState extends State<newevent> {
  final storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  ///declaring variables
  late String username;
  late String email;
  late String mobile;
  late String address;
  late String dob;
  late String dad;
  late String mom;

  late String pw;
  late String pw2;
  late String iurl;

  ///variales end
  ///
  ///function to set data to userfield
  Future<void> addstudent(
    String username,
    String email,
    String mobile,
    String address,
    String dob,

    ///meka cut krpn
    String thisurl,
    String momname,
    String dadname,
  ) async {
    // await _firestore.collection('userdetails').add({'email': email, 'pw': pw});
    await FirebaseFirestore.instance.collection('students').doc(email).set({
      'username': username,
      'email': email,
      'mobile': mobile,
      'address': address,
      'dob': dob,

      ///meka cut krpn
      'url': thisurl,
      'mom': momname,
      'dad': dadname,
    });
  }

  ///creating users function begin
  void createstudent() async {
    try {
      final newuser = await _auth.createUserWithEmailAndPassword(
          email: email, password: pw);

      ///call the add details function here
      addstudent(username, email, mobile, address, dob, iurl, mom, dad);

      if (newuser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => lec_dashboard()),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => lec_dashboard()),
              );
            },
          ),
          title: Text(
            'Enroll new Student',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xFF19589D),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
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
                                  ? Image.asset('assets/img1.png')
                                  : Image.file(_image!),

                          /*IconButton(
                              icon: myIcon,
                              onPressed: null,
                            ),*/
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  //username
                  TextFormField(
                    onChanged: (value) {
                      username = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
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
                      mobile = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                      labelText: 'Mobile',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //address
                  TextFormField(
                    onChanged: (value) {
                      address = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_city,
                      ),
                      labelText: 'Address',
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
                      labelText: 'Date of Birth',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //mom
                  TextFormField(
                    onChanged: (value) {
                      mom = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.woman),
                      ),
                      labelText: 'Mothers Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //dad
                  TextFormField(
                    onChanged: (value) {
                      dad = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.man),
                      ),
                      labelText: 'Fathers Name',
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
                    height: 32.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF19589D))),
                    onPressed: () {
                      if (pw == pw2) {
                        createstudent();
                        AlertDialog alert = AlertDialog(
                          title: Text("Succesful"),
                          content: Text("New Student Added."),
                          actions: [
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                MaterialPageRoute(
                                    builder: (context) => lec_dashboard());
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => lec_dashboard()),
                                );
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
