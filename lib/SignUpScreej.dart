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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextField(
          controller: NameEditController,
          decoration: InputDecoration(
              hintText: "Full Name",
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w300, color: Colors.red)),
        ),
        TextField(
          controller: EmailEditController,
          decoration: InputDecoration(
              hintText: "Email",
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w300, color: Colors.red)),
        ),
        TextField(
          controller: PaswordEditController,
          decoration: InputDecoration(
              hintText: "Password",
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w300, color: Colors.red)),
        ),
        TextField(
          controller: PhoneEditController,
          decoration: InputDecoration(
              hintText: "phone",
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w300, color: Colors.red)),
        ),
        TextField(
          controller: AddressEditController,
          decoration: InputDecoration(
              hintText: "Address",
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w300, color: Colors.red)),
        ),
        SizedBox(
          height: 30.0,
        ),
        FlatButton(
          onPressed: ()async {
            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            //     groceryMain()), (Route<dynamic> route) => false);

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
          },


          child: Text("SignUp"),
        ),

        SizedBox(height: 30.0,),
        GestureDetector(
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  Login()), (Route<dynamic> route) => false);
            },
            child: Text("Already Have Account?"))

      ]),
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
