import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/screens/promo_code.dart';

class CoupanList extends StatefulWidget {
  @override
  _CoupanListState createState() => _CoupanListState();
}

class _CoupanListState extends State<CoupanList> {
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
          "Coupan List",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          FlatButton(
            textColor: Colors.red.shade900,
            onPressed: () {},
            child: Icon(Icons.notification_important_outlined),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(
                    decoration: BoxDecoration(color: Colors.green.shade900),
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                      Text(
                        'Rate',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                      Text(
                        'Status',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                      Text(
                        'Expiry Date',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ]),
                TableRow(
                    decoration: BoxDecoration(color: Colors.green.shade100),
                    children: [
                      Text('Coupan 1', style: TextStyle(fontSize: 20.0)),
                      Text('20%', style: TextStyle(fontSize: 20.0)),
                      Text('ON', style: TextStyle(fontSize: 20.0)),
                      Text('10/9/2021', style: TextStyle(fontSize: 20.0)),
                    ]),
                TableRow(
                    decoration: BoxDecoration(color: Colors.green.shade100),
                    children: [
                      Text('Coupan 2', style: TextStyle(fontSize: 20.0)),
                      Text('15%', style: TextStyle(fontSize: 20.0)),
                      Text('OFF', style: TextStyle(fontSize: 20.0)),
                      Text('17/3/2021', style: TextStyle(fontSize: 20.0)),
                    ]),
                TableRow(
                    decoration: BoxDecoration(color: Colors.green.shade100),
                    children: [
                      Text('Coupan 3', style: TextStyle(fontSize: 20.0)),
                      Text('10%', style: TextStyle(fontSize: 20.0)),
                      Text('ON', style: TextStyle(fontSize: 20.0)),
                      Text('8/12/2021', style: TextStyle(fontSize: 20.0)),
                    ]),
                TableRow(
                    decoration: BoxDecoration(color: Colors.green.shade100),
                    children: [
                      Text('Coupan 4', style: TextStyle(fontSize: 20.0)),
                      Text('25%', style: TextStyle(fontSize: 20.0)),
                      Text('ON', style: TextStyle(fontSize: 20.0)),
                      Text('10/10/2021', style: TextStyle(fontSize: 20.0)),
                    ]),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                    height: 50,
                    color: Colors.green.shade600,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => PromoCode()));
                    },
                    child: Text(
                      "Add New Coupan",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
