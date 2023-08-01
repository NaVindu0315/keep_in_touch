import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keep_in_touch/eventlistview.dart';
import 'package:keep_in_touch/login.dart';
import 'package:keep_in_touch/newevent.dart';

late User loggedinuser;
late String client;

void main() {
  runApp(lec_dashboard());
}

class lec_dashboard extends StatefulWidget {
  @override
  State<lec_dashboard> createState() => _lec_dashboardState();
}

class _lec_dashboardState extends State<lec_dashboard> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => login()),
            );
          },
        ),
        title: Text(
          'Lecturer Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF19589D),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(client)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Column(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      height: 100, // Set the desired height
                      decoration: BoxDecoration(
                        color: Color(0xFF19589D),
                        borderRadius:
                            BorderRadius.circular(50), // Set the desired color
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Text(
                              'Welcome ${data!['boyname']} & ${data!['girlname']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 170.0,
                          ),
                          Expanded(
                            child: CircleAvatar(
                              backgroundColor: Colors.purple,
                              minRadius: 70.5,
                              child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage:
                                      //AssetImage('images/g.png'),
                                      NetworkImage('${data!['url']}')),
                            ),
                            /*
                            CircleAvatar(
                              radius: 50.0,
                              child: Image(
                                image: NetworkImage('${data!['url']}'),
                              ),
                            ),*/
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 150,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.purple,
                                          minRadius: 70.5,
                                          child: CircleAvatar(
                                              radius: 70,
                                              backgroundImage:
                                                  //AssetImage('images/g.png'),
                                                  NetworkImage(
                                                      '${data!['url']}')),
                                        ),
                                      ),

                                      /////////
                                      Container(
                                        padding: EdgeInsets.all(
                                            8.0), // set the padding
                                        decoration: BoxDecoration(
                                          color: Color(
                                              0xFF19589D), // set the background color
                                          borderRadius: BorderRadius.circular(
                                              10.0), // set the border radius
                                        ),
                                        height: 60,
                                        width: double.infinity,
                                        //color: const Color(0xDBD6EFFF),
                                        child:

                                            ///username row
                                            Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'email :',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 22,
                                                  height: 2,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                //////email variable
                                                client,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 22,
                                                  height: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),

                                      ///mobile
                                      Container(
                                        padding: EdgeInsets.all(
                                            8.0), // set the padding
                                        decoration: BoxDecoration(
                                          color: Color(
                                              0xFF19589D), // set the background color
                                          borderRadius: BorderRadius.circular(
                                              10.0), // set the border radius
                                        ),
                                        height: 60,
                                        width: double.infinity,
                                        //color: const Color(0xDBD6EFFF),
                                        child:

                                            ///username row
                                            Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Boyname :',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 22,
                                                  height: 2,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                //////mobile variable
                                                '${data!['boyname']}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 22,
                                                  height: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),

                                      /////////
                                      ///address
                                      Container(
                                        padding: EdgeInsets.all(
                                            6.0), // set the padding
                                        decoration: BoxDecoration(
                                          color: Color(
                                              0xFF19589D), // set the background color
                                          borderRadius: BorderRadius.circular(
                                              10.0), // set the border radius
                                        ),
                                        height: 60,
                                        width: double.infinity,
                                        // color: const Color(0xDBD6EFFF),
                                        child:

                                            ///username row
                                            Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'GirlName :',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 22,
                                                  height: 2,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                //////username variable
                                                '${data!['girlname']}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 22,
                                                  height: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),

                                      ///dob
                                      Container(
                                        height: 60,
                                        width: double.infinity,
                                        padding: EdgeInsets.all(
                                            8.0), // set the padding
                                        decoration: BoxDecoration(
                                          color: Color(
                                              0xFF19589D), // set the background color
                                          borderRadius: BorderRadius.circular(
                                              10.0), // set the border radius
                                        ),
                                        //: const Color(0xDBD6EFFF),
                                        child:

                                            ///username row
                                            Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'DOB:',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 22,
                                                  height: 2,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                //////username variable
                                                '${data!['dob']}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 22,
                                                  height: 2,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50.0,
                                      ),
                                      Container(
                                          height: 60,
                                          width: double.infinity,
                                          padding: EdgeInsets.all(
                                              8.0), // set the padding
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .white, // set the background color
                                            borderRadius: BorderRadius.circular(
                                                10.0), // set the border radius
                                          ),
                                          //: const Color(0xDBD6EFFF),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  // Add your action for the "List" button here
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            eventlist()),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.blue,
                                                ),
                                                child: Text('List'),
                                              ),
                                              SizedBox(
                                                  width:
                                                      10), // Add some space between the buttons
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            newevent()),
                                                  );
                                                  // Add your action for the "Add New" button here
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.blue,
                                                ),
                                                child: Text('Add New'),
                                              ),
                                            ],
                                          )),

                                      /////////
                                      /////////
                                      /////////
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///fff
                      ],
                    ),
                  )

                  ///another row

                  ///

                  ///
                ],
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
/*

 */

/*

 */
