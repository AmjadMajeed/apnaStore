import 'package:flutter/material.dart';
import 'package:flutter_ui/Models/userProfileModel.dart';

import 'edit_profile.dart';

class MyProfile extends StatelessWidget {
  UserProfileModel userInfo;
  MyProfile(this.userInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            tooltip: "back",
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "My Profile",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          actions: [
            FlatButton(
              textColor: Colors.red.shade900,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              child: Text("EDIT",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 25.0,left: 40,right: 40),
            child: Form(
                child: Column(
                  children: [
                    Text("(Name)",style: TextStyle(fontSize: 20.0,color: Colors.red.shade900),),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                          hintText: "${userInfo.profile.first.fullName}",
                          hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                          labelStyle:TextStyle(
                              color: Colors.red.shade900,

                          )
                      ),

                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text("(Email)",style: TextStyle(fontSize: 20.0,color: Colors.red.shade900),),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                          hintText: "${userInfo.profile.first.email}",
                          hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                          labelStyle:TextStyle(
                            color: Colors.red.shade900,

                          )
                      ),

                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text("(Mobile Number)",style: TextStyle(fontSize: 20.0,color: Colors.red.shade900),),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                          hintText: "${userInfo.profile.first.phone}",

                          hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                          labelStyle:TextStyle(
                            color: Colors.red.shade900,

                          )
                      ),

                    ),SizedBox(
                      height: 30.0,
                    ),
                    // Text("(Date of Birth)",style: TextStyle(fontSize: 20.0,color: Colors.red.shade900),),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                    //       focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                    //       hintText: "${userInfo.profile.first}",
                    //
                    //       hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                    //       labelStyle:TextStyle(
                    //         color: Colors.red.shade900,
                    //
                    //       )
                    //   ),
                    //
                    // ),SizedBox(
                    //   height: 30.0,
                    // ),
                    // Text("(Gender)",style: TextStyle(fontSize: 20.0,color: Colors.red.shade900),),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                    //       focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                    //       hintText: "${userInfo.profile.first.}",
                    //
                    //       hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                    //       labelStyle:TextStyle(
                    //         fontSize: 30.0,
                    //         color: Colors.red.shade900,
                    //
                    //       )
                    //   ),

                    // ),SizedBox(
                    //   height: 30.0,
                    // ),
                    // Text("(Location)",style: TextStyle(fontSize: 20.0,color: Colors.red.shade900),),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //       enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                    //       focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                    //       hintText: "Location on Map (req to optimise store)",
                    //       hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                    //       labelStyle:TextStyle(
                    //         color: Colors.red.shade900,
                    //
                    //       )
                    //   ),

                    // ),
                    // SizedBox(
                    //   height: 30.0,
                    // ),
                    Text("(Complete Address)",style: TextStyle(fontSize: 20.0,color: Colors.red.shade900),),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                          hintText: "${userInfo.profile.first.address}",

                          hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                          labelStyle:TextStyle(
                            color: Colors.red.shade900,

                          )
                      ),

                    ),
                    SizedBox(
                      height: 30.0,
                    ),

                  ],
                )),
          ),
        ));
  }
}
