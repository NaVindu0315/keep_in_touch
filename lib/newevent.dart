import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'dashboard.dart';

late BuildContext dialogcontext;

late User loggedinuser;
late String client;
TextEditingController c1 = new TextEditingController();
TextEditingController c2 = new TextEditingController();
TextEditingController c3 = new TextEditingController();

class newevent extends StatefulWidget {
  late User loggedinuser;
  late String client;

  void main() {
    runApp(newevent());
  }

  @override
  State<newevent> createState() => _neweventState();
}

class _neweventState extends State<newevent> {
  static String id = 'addgempage';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getcurrentuser();
  }

  void getcurrentuser() async {
    try {
      // final user = await _auth.currentUser();
      ///yata line eka chatgpt code ekk meka gatte uda line eke error ekk ena hinda hrytama scene eka terenne na
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        loggedinuser = user;
        client = loggedinuser.email!;

        ///i have to call the getdatafrm the function here and parse client as a parameter

        print(loggedinuser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  final storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  //final _firestore = FirebaseFirestore.instance;
  var gemController = TextEditingController();
  late String? title;
  late String? date;
  late String? description;

  late String gemurl;

  File? _image;
  Image myIcon = Image.asset('assets/img1.png');

  ///add event
  Future<void> addnwevent() async {
    final gemsRef = _firestore.collection(client).doc(date);
    gemsRef.set({
      'gemurl': gemurl,
      'title': title,
      'date': date,
      'description': description,
    });

    AlertDialog alert = AlertDialog(
      title: Text("New Event Added"),
      content:
          Text("New Memory : $title created waiting for many more to come"),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => lec_dashboard()),
            );
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogcontext = context;
        return alert;
      },
    );
    Navigator.of(dialogcontext).pop();
  }

  /// add event end

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      ///meke tyyna hamahuttama kapapan
      final ref = storage.ref().child('images/${DateTime.now().toString()}');
      final uploadTask = ref.putFile(File(pickedImage.path));
      final snapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL();
      gemurl = imageUrl;
      _image = File(pickedImage.path);

      setState(() {
        myIcon = Image.asset('pickedImage');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image(
                          image: AssetImage("assets/img1.png"),
                          width: 200, // Set the desired width of the image
                          height: 150, // Set the desired height of the image
                        ),
                      ),
                    ],
                  ),

                  InkWell(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.deepPurpleAccent,
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
                  ),
                  /*ElevatedButton.icon(
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.purple,
                    ),
                    label: const Text(
                      'Add New Gem',
                      style: TextStyle(
                        color: Colors.purple,
                      ),
                    ),
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                      elevation: const MaterialStatePropertyAll(5.0),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                  ),*/
                  TextFormField(
                    controller: c1,
                    onChanged: (value) {
                      title = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.people,
                      ),
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  ///date
                  TextFormField(
                    controller: c2,
                    onChanged: (value) {
                      date = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.date_range,
                      ),
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  ///descrption
                  TextFormField(
                    controller: c3,
                    onChanged: (value) {
                      description = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.type_specimen,
                      ),
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  ///ddddddddddddddddddddddd

                  Row(
                    children: [
                      Expanded(
                        child: BottomButton(
                          label: 'Back',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: BottomButton(
                          label: 'Submit',
                          onPressed: () {
                            addnwevent();
                          },
                        ),
                      ),
                    ],
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

class BottomButton extends StatelessWidget {
  const BottomButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(Colors.purple),
        elevation: const MaterialStatePropertyAll(5.0),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
      child: Text(
        label,
      ),
    );
  }
}

class UserInputs extends StatelessWidget {
  const UserInputs(
      {super.key,
      this.hintText,
      this.errorMessage,
      this.onSaved,
      this.controller});

  final String? hintText;
  final String? errorMessage;
  final void Function(String? value)? onSaved;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
