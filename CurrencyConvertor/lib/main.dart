import 'package:currencyconvertor/Home.dart';
import 'package:currencyconvertor/Logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main()
{
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MultiProvider(
            providers:[
              ChangeNotifierProvider(create: (context)=>HomeLogic())
            ],
          child:MyHome() ,
        ),

      ),
    );
  }
}
