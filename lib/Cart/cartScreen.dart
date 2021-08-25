import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/Models/orderPlaceMsgTokan.dart';
import 'package:flutter_ui/Models/todoModel.dart';
import 'package:flutter_ui/grocery/groceryMainCheck.dart';
import 'package:flutter_ui/main.dart';
import 'package:localstore/localstore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';




class CartScreen extends StatefulWidget {
  // TokenModel tokenModel;
  // UserInfoModel userInfoModel;
  //
  // CartScreen(this.tokenModel, this.userInfoModel);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late OrderPlaceMsgModel responseMsg ;
  var token;
  var sendorderList=[];
  var item;
  List itemname = [
    'Home Appliances',
    'Electric item',
  ];

  var subTotal = 0.0;
  int counter = 0;

  final _db = Localstore.instance;
  final _items = <String, Todo>{};
  late StreamSubscription<Map<String, dynamic>> _subscription;
  TextEditingController discountEditingController =
      TextEditingController(text: "0");
  TextEditingController texEditingController = TextEditingController(text: "0");

  late bool isAdded;

  @override
  void initState() {
    isAdded = false;
    getTokenFromSp();
    _subscription = _db
        .collection('todos')
        .doc("ABC")
        .collection("cart")
        .stream
        .listen((event) {
      setState(() {
        final item = Todo.fromMap(event);
        _items.putIfAbsent(item.id, () => item);
        print(_items.entries.length);
        print("ffffffffffffffffffff");
        for (var i = 1; i <= 1; i++) {
          subTotal = subTotal + double.parse(item.price);
        }
        print("ggggggggggggggggg");
        print(subTotal);
        print("ggggggggggggggggg");
      });
    });
    if (kIsWeb) _db.collection('todos').stream.asBroadcastStream();

    super.initState();
  }

  ///Total amout on buttom sheet after plus
  double subTotalCountMethod(Todo item) {
    setState(() {
      print("heeeeeeeeeeeeeeeeeee");
      subTotal = subTotal + double.parse(item.price);
      print(subTotal);
      print("mmm");
    });
    return 1;
  }

  ///Total amout on buttom sheet after negtive
  double nevTotalCountMethod(Todo item) {
    setState(() {
      print("haaa");
      subTotal = subTotal - double.parse(item.price);
      print(subTotal);
      print("mmm");
    });
    return 1;

  }

  late Object _itemVal;

  Widget expasion(Todo item) {
    double counter = double.parse(item.price);
    // var testCounter = 1;
    // print(item.quantity);print("this is quantity");print(item.price);print("this is price");
    var testCounter = counter * item.quantity;
    // subTotal = testCounter ;
    // if(sendorderList.contains(item.title))
    //   {
    //     sendorderList.remove([
    //       item.title,
    //         item.price,
    //         item.quantity
    //     ]);
    //     var item1 = item.title;
    //
    // sendorderList.removeWhere((item1) => item1 == '${item1}');

        sendorderList.add([
          item.title,
          item.price,
          item.quantity,
          item.productId,
          item.itemInStock,
          item.price,
        ]);
      // }
   // sendorderList.add([
   //   item.title,
   //   item.price,
   // ]);

    print(sendorderList);
    print("*******+++++++++++++++");

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.11,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${item.title}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Text(
                      "Size: L",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                    Container(
                      height: 20.0,
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${item.price}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (item.quantity > 1) {
                                        setState(() {
                                          // counter--;
                                          item.quantity--;
                                          nevTotalCountMethod(item);
                                        });
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      color: Colors.grey[400],
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${item.quantity}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setState(() {
                                        // item.quantity ++;

                                        String newValue =
                                            (item.quantity++).toString();
                                        testCounter = double.parse(newValue) *
                                            double.parse(item.price);
                                        print(
                                            "this is new counter $testCounter this is new Value ");
                                        subTotalCountMethod(item);
                                      });
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      color: Colors.blue,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                             deleteFunction(item);

                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    ' Delete',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ExpansionTile(
            title: RichText(
              text: TextSpan(
                  text: "Total: ",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                  children: [
                    TextSpan(
                      text: "\$$testCounter",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ]),
            ),

          ),
        ],
      ),
    );
  }

  int index = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 5,
          elevation: 1,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_sharp,
              color: Colors.green,
              size: 24,
            ),
          ),
          title: Text(
            'My Cart',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.12,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Sub Total:  ',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '\$$subTotal',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {

                          print('sendorderList');
                          print(sendorderList);
                          print(sendorderList);
                          print(sendorderList);


                          postOrders();
                          showAlertDialog(context);
                        },
                        child: Text("CHECK OUT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 12,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          '1. Your Bill',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 5
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 2,
                    color: Colors.grey,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.grey,
                          size: 12,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          '2. Place Order',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 5
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 2,
                    color: Colors.grey,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.grey,
                          size: 12,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          '3. Complete',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 5
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final key = _items.keys.elementAt(index);
                     item = _items[key];
                    return expasion(item!);
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }





void deleteFunction(Todo item){
  var  subTotal2;
  print("4444444444444444444"); print(item.price);print("4444444444444444444");
  setState(() {
    item.delete("ABC");
    _items.remove(item.id);
    subTotal2 =  subTotal - double.parse(item.price);
    subTotal = subTotal2;

  });
}


  void onCheckOutPress(){
    var subtotal1;
    setState(() {
      subtotal1 = subTotal;
    });
    if (discountEditingController.text != "0") {
      if (discountEditingController.text.contains("%")) {
        var newValue;
        setState(() {
          newValue = discountEditingController.text
              .replaceAll(new RegExp(r'[^\w\s]+'), '');
        });

        subTotal = subTotal -
            subTotal / 100 * int.parse(newValue);
      } else {
        subTotal = subTotal -
            int.parse(discountEditingController.text);
      }
    }

    if (texEditingController.text != "0") {
      if (texEditingController.text.contains("%")) {
        var newValue;
        setState(() {
          newValue = texEditingController.text
              .replaceAll(new RegExp(r'[^\w\s]+'), '');
          print(newValue);
        });
        subTotal = subTotal -
            subTotal / 100 * int.parse(newValue);
      } else {
        subTotal = subTotal -
            int.parse(texEditingController.text);
      }
    }
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => CheckOutCash(
    //       widget.tokenModel.accessToken, subTotal),),);

    Future.delayed(Duration(seconds: 2), () {
      if (discountEditingController.text.contains("%")) {
        var newValue;
        setState(() {
          newValue = discountEditingController.text
              .replaceAll(new RegExp(r'[^\w\s]+'), '');
          print(newValue);
        });
        subTotal = subtotal1;
      } else {
        subTotal = subTotal +
            int.parse(discountEditingController.text);
      }

      if (texEditingController.text.contains("%")) {
        var newValue;
        setState(() {
          newValue = texEditingController.text
              .replaceAll(new RegExp(r'[^\w\s]+'), '');
          print(newValue);
        });
        subTotal = subtotal1;
      } else {
        subTotal = subTotal +
            int.parse(texEditingController.text);
      }
      discountEditingController.text = "0";
      texEditingController.text = "0";
    });

  }


  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {

        Navigator.of(context).pop();

        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        //   groceryMain()), (Route<dynamic> route) => false);
        },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Order Completed"),
      content: Text("Order Placed Successfully."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // ignore: non_constant_identifier_names
  Future<OrderPlaceMsgModel?> PlaceOrder() async {
    final String apiUrl = "https://new-apna-store.herokuapp.com/api/createorder";

    Map<String, dynamic> args = {
      "orderItems":[{
        "name":"hhhshfhf",
        "price":"90",
        "imageUrl":"https://upload.wikimedia.org/wikipedia/en/thumb/8/87/Forza_Horizon_4_cover.jpg/220px-Forza_Horizon_4_cover.jpg",
        "qty":2,
        "countInStock":5,
        "product":"6110e18dd96d2f22a497fb56"
      },
        {
          "name":"hhhshfhf",
          "price":"90",
          "imageUrl":"https://upload.wikimedia.org/wikipedia/en/thumb/8/87/Forza_Horizon_4_cover.jpg/220px-Forza_Horizon_4_cover.jpg",
          "qty":2,
          "countInStock":5,
          "product":"6110e1f088210c361cf32d3d"
        }

      ],
      "totalPrice":"1000",
      "itemsPrice":"500",
      "orderStatus":"pending"
    };
    var body = json.encode(args);
    print("Login Method Runs");

    print(json.encode(args));
    final response = await http.post(Uri.parse(apiUrl), body: body,headers: {
      "x-auth-token": token
    }
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      var responseString = response.body;

      return orderPlaceMsgModelFromJson(responseString);
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


  postOrders() async {

    final OrderPlaceMsgModel? user = await PlaceOrder();

    setState(() {
      responseMsg = user!;
      // totalProductPrice = totalPaymentCalculateMethod();

    });
    if(responseMsg == null)
    {
      ToastMsg(Colors.red,"Something went Wrong,try again",);
    }
    else
    {

      // ToastMsg(Colors.green,"Login SUccessfull",);
      print("this is Tokan...............");
      print(responseMsg.message);print("===============");
      // Navigator.push(context, MaterialPageRoute(builder: (_)=>Home(_tokenModel)));
    }
  }

  void getTokenFromSp()async {
    final prefs = await SharedPreferences.getInstance();
     token = prefs.getString('token') ?? '';
    print(token);
  }
}
