import 'package:flutter/material.dart';

import 'coupan_list.dart';

class PromoCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            tooltip: "back",
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CoupanList()));
            }),
        title: Text(
          "Promo-Code",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Center(
                child: Column(
              children: [
                Image.asset("assets/coupan.jpg"),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Write Promo Code here:",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Coupan Title";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        labelText: "Coupan Title",
                        suffixIcon: Icon(Icons.edit),
                        labelStyle: TextStyle(color: Colors.green.shade900)),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: FlatButton(
                            color: Colors.green.shade600,
                            onPressed: () {},
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    )
                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
