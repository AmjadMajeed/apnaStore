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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 40.0, left: 40.0),
                  child: TextFormField(
                    controller : EmailEditController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Email",
                        fillColor: Colors.green.shade100),
                  ),
                ),
                SizedBox(
                  height: 10.0,
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
                        hintText: "Password",
                        fillColor: Colors.green.shade100),
                  ),
                ),

                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, bottom: 12.0, right: 35.0, left: 35.0),
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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
                    }),


                SizedBox(height: 30.0,),
                GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          SignUpScreen()), (Route<dynamic> route) => false);
                    },
                    child: Text("Not register Yet?"))
              ],
            ),
          ),
        ),
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
