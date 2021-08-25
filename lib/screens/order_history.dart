import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              tooltip: "back",
              onPressed: () {
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => CoupanList()));
              }),
          title: Text(
            "Order History",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          actions: [
            FlatButton(
              textColor: Colors.red.shade900,
              onPressed: () {},
              child: Icon(Icons.notes),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                UserPhotoWidget(),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  thickness: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Joe Root",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 25.0,
                            color: Colors.green.shade700),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Row(

                        children: [
                          Image.asset(
                            "assets/utencils.jpg",
                            height: 70,
                            width: 70,
                          ),
                          Text(
                            "Grocery",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25.0,
                                color: Colors.green.shade700),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on,color: Colors.grey.shade700,),
                          Text(
                            "Sydney",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20.0,
                                color: Colors.grey.shade900),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Likes",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 22.0,
                                color: Colors.green.shade900),
                          ),
                          Text(
                            "1584",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                                color: Colors.green.shade600),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Offers",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 22.0,
                                color: Colors.green.shade900),
                          ),
                          Text(
                            "108",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                                color: Colors.green.shade600),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discounts",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 22.0,
                                color: Colors.green.shade900),
                          ),
                          Text(
                            "53",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                                color: Colors.green.shade600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your History",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            color: Colors.black),
                      ),
                      Icon(Icons.more_vert_outlined,color: Colors.blueGrey.shade700,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                  child: HistoryCardWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                  child: HistoryCardWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                  child: HistoryCardWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                  child: HistoryCardWidget(),
                ),




              ],
            ),
          ),
        ));
  }
}

class UserPhotoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height * 0.4,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(180.0)),
              image: DecorationImage(
                image: AssetImage("assets/grocery.jpg"),
                fit: BoxFit.cover,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 230, right: 230),
          child: Container(
            height: size.height * 0.13,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.5),
                image: DecorationImage(
                    image: AssetImage("assets/ppp.jpg"), fit: BoxFit.contain),
                boxShadow: [
                  BoxShadow(
                      color: Colors.green.shade900,
                      offset: Offset(1.5, 1.5),
                      spreadRadius: 2.5,
                      blurRadius: 2.5)
                ]),
          ),
        )
      ],
    );
  }
}



class HistoryCardWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: AssetImage("assets/cake.jpg"),
                  fit: BoxFit.fill
                )
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hot Chocolate",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.grey.shade900),
                ),
                SizedBox(height: 15.0,),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite,color: Colors.red.shade700,),
                        Text(
                          "45K",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.grey.shade900),
                        ),
                      ],
                    ),
                    SizedBox(width: 20.0,),
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.lightBlueAccent.shade700,),
                        Text(
                          "38K",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.grey.shade900),
                        ),
                      ],
                    ),

                  ],
                ),
                Text(
                  "Got on Nov 20, 2021",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.grey.shade500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

