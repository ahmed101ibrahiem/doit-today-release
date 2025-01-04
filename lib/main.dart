import 'package:doit_today/app_widget.dart';
import 'package:doit_today/core/base/injection/locator.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}



