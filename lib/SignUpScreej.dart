import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/screens/login.dart';
import 'package:http/http.dart' as http;

import 'Models/SignUpUserModel.dart';
import 'grocery/groceryMainCheck.dart';
import 'main.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController NameEditController = TextEditingController();
  TextEditingController EmailEditController = TextEditingController();
  TextEditingController PaswordEditController = TextEditingController();
  TextEditingController PhoneEditController = TextEditingController();
  TextEditingController AddressEditController = TextEditingController();
  // Size size = MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.blue,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40.0, left: 40.0),
                  child: TextFormField(
                    controller: NameEditController,
                    validator: (val) =>
                    val!.isEmpty ? 'Enter a User Name' : null,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "User Name",
                        fillColor: Colors.green.shade100),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20.0),
                  child: TextFormField(
                    controller: EmailEditController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        icon: Icon(Icons.mail_outline_rounded),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Your Email",
                        fillColor: Colors.green.shade100),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20.0),
                  child: TextFormField(
                    controller: PaswordEditController,
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Your Password",
                        fillColor: Colors.green.shade100),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20.0),
                  child: TextFormField(
                    controller: PhoneEditController,
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Phone",
                        fillColor: Colors.green.shade100),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20.0),
                  child: TextFormField(
                    controller: AddressEditController,
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Address",
                        fillColor: Colors.green.shade100),
                  ),
                ),

                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                    elevation: 6.0,
                    color: Colors.green.shade300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, bottom: 12.0, right: 35.0, left: 35.0),
                      child: Text(
                        "Sign UP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () async {
                      SignUpUserModel? user = await SignUpMethod(NameEditController.text.toString().trim(),
                          EmailEditController.text.toString().trim(),
                          PaswordEditController.text.toString().trim(),
                          PhoneEditController.text.toString().trim(),
                          AddressEditController.text.toString().trim());

                      if(user != null){
                        ToastMsg(
                          Colors.red,
                          "Register SuccessFull",
                        );
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            Login()), (Route<dynamic> route) => false);

                      }
                    }),

                SizedBox(height: 30.0,),
                GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          Login()), (Route<dynamic> route) => false);
                    },
                    child: Text("Already Have Account?"))

              ]),
            ),
          ),
        ),
      ),
    );
  }

  

  Future<SignUpUserModel?> SignUpMethod(String fullName,String Email, String password, var Phone,String Address) async {
    final String apiUrl = "https://new-apna-store.herokuapp.com/api/register";

    print("creatUserMethod Runs");

    final response = await http.post(Uri.parse(apiUrl), body: {
      "fullName": fullName,
      'email': Email,
      'password': password,
      'phone': Phone,
      'address': Address
    });

    print(response.statusCode);

    if (response.statusCode == 200) {
       var responseString = response.body;

      return signUpUserModelFromJson(responseString);
    } else if(response.statusCode == 401) {
      ToastMsg(
        Colors.red,
        "UserName Or Password Is Incorrect",
      );
      return null;
    }
    else {
      ToastMsg(
        Colors.red,
        "Something Goes Wrong",
      );
      return null;
    }
  }
}
