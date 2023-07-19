import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keep_in_touch/login.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(home());
}

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: login(),
    );
  }
}
