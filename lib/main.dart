
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
/*

  해야 할 것.
  1. 로고
  2. 다이얼러그 다듬기
  3. 써큘러 다듬기등등
  4. splash screen
 */