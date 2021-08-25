import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/Models/LoginMethod.dart';
import 'package:flutter_ui/Models/SignUpUserModel.dart';
import 'package:flutter_ui/Models/userProfileModel.dart';
import 'package:flutter_ui/grocery/groceryMainCheck.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../SignUpScreej.dart';
import '../main.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController EmailEditController = TextEditingController();
  TextEditingController PaswordEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 80.0,),
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

          FlatButton(
            onPressed: ()async {


              LoginModel? user = await LoginMethod(
                EmailEditController.text.toString().trim(), PaswordEditController.text.toString().trim(),);


              if(user != null){

                saveTokenToSP(user.token);
                ToastMsg(
                  Colors.blue,
                  "WellCOme",
                );
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    groceryMain(user)), (Route<dynamic> route) => false);

              }
            },
            child: Text("Login"),
          ),
          SizedBox(height: 30.0,),
          GestureDetector(
              onTap: (){
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    SignUpScreen()), (Route<dynamic> route) => false);
              },
              child: Text("Not register Yet?"))
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<LoginModel?> LoginMethod(String Email, String password,) async {
    final String apiUrl = "https://new-apna-store.herokuapp.com/api/login";

    print("Login Method Runs");

    final response = await http.post(Uri.parse(apiUrl), body: {
      'email': Email,
      'password': password,
    });

    print(response.statusCode);

    if (response.statusCode == 200) {

      var responseString = response.body;

      return loginModelFromJson(responseString);
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

  void saveTokenToSP(String token) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

}
