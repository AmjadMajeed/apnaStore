import 'package:flutter/material.dart';

import 'my_profile.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            tooltip: "back",
            onPressed: (){
              // Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: (context) => MyProfile()));
            },
          ),
          title: Text(
            "Edit Profile",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red.shade900),
          ),
          centerTitle: true,
          actions: [
            FlatButton(
              textColor: Colors.red.shade900,
              onPressed: () {},
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
                    Text("(Name)",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                          hintText: "Enter your Name",
                          hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                          labelStyle:TextStyle(
                            color: Colors.red.shade900,

                          )
                      ),

                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text("(Email)",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                          hintText: "Enter your email",
                          hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                          labelStyle:TextStyle(
                            color: Colors.red.shade900,

                          )
                      ),

                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text("(Mobile Number)",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                          hintText: "Enter your Mobile Number",
                          hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                          labelStyle:TextStyle(
                            color: Colors.red.shade900,

                          )
                      ),

                    ),SizedBox(
                      height: 30.0,
                    ),
                    Text("(Date of Birth)",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                          hintText: "Enter your DOB",
                          hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                          labelStyle:TextStyle(
                            color: Colors.red.shade900,

                          )
                      ),

                    ),SizedBox(
                      height: 30.0,
                    ),
                    Text("(Gender)",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                          hintText: "Gender",
                          hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                          labelStyle:TextStyle(
                            fontSize: 30.0,
                            color: Colors.red.shade900,

                          )
                      ),

                    ),SizedBox(
                      height: 30.0,
                    ),
                    Text("(Location)",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                          hintText: "Location on Map (req to optimise store)",
                          hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                          labelStyle:TextStyle(
                            color: Colors.red.shade900,

                          )
                      ),

                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text("(Complete Address)",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                    TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red.shade900,width: 3.0)),
                          hintText: "House # (for delivery",
                          hintStyle: TextStyle(fontSize: 15.0,color: Colors.black),
                          labelStyle:TextStyle(
                            color: Colors.red.shade900,

                          )
                      ),

                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    RaisedButton(
                        elevation: 6.0,
                        color: Colors.red.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, right: 45.0, left: 45.0),
                          child: Text(
                            "Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(builder: (context) => MyProfile()));
                        }),
                    SizedBox(
                      height: 50.0,
                    ),

                  ],
                )),
          ),
        ));
  }
}
