import 'package:flutter/material.dart';
import 'package:flutter_ui/screens/login.dart';
import 'package:flutter_ui/screens/order_history.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'Models/Product.dart';
import 'SignUpScreej.dart';
import 'grocery/categories.dart';
import 'grocery/groceryMainCheck.dart';
import 'grocery/my_cart.dart';
import 'grocery/product_detail.dart';


void main() {
  runApp(MyApp());
}

void ToastMsg(color,msg)
{
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    // return groceryMain();
    return Login();
  }




}
