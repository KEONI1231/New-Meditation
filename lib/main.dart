
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'Screen/intro_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      home: MyApp(), // 시작 부분.
    ),
  );
}
