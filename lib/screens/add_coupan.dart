import'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coupan_list.dart';

class AddCoupan extends StatefulWidget {
  @override
  _AddCoupanState createState() => _AddCoupanState();
}

class _AddCoupanState extends State<AddCoupan> {
  final _formkey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  bool _active = false;

  _selectdate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

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
          "Add/Edit Discounts",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          FlatButton(
            textColor: Colors.red.shade900,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => CoupanList()));
            },
            child: Text(
              "GO",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Coupan Title";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      labelText: "Coupan Title",
                      labelStyle: TextStyle(color: Colors.green.shade900)),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Discount %";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      labelText: "Discount %",
                      labelStyle: TextStyle(color: Colors.green.shade900)),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Apply Expiry Date";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      labelText: "Apply Expiry Date",
                      labelStyle: TextStyle(
                        color: Colors.green.shade900,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          _selectdate();
                        },
                        child: Icon(Icons.date_range_outlined),
                      )),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Coupan Details";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      labelText: "Enter Coupan Details",
                      labelStyle: TextStyle(color: Colors.green.shade900)),
                ),
                SwitchListTile(
                    activeColor: Colors.blue.shade700,
                    contentPadding: EdgeInsets.zero,
                    title: Text("Activate Coupan"),
                    value: _active,
                    onChanged: (bool newvalue) {
                      setState(() {
                        _active = !_active;
                      });
                    }),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                          color: Colors.green.shade600,
                          onPressed: () {},
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
