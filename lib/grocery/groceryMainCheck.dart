import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_ui/Cart/cartScreen.dart';
import 'package:flutter_ui/Models/LoginMethod.dart';
import 'package:flutter_ui/Models/Product.dart';
import 'package:flutter_ui/Models/todoModel.dart';
import 'package:flutter_ui/Models/userProfileModel.dart';
import 'package:flutter_ui/grocery/product_detail.dart';
import 'package:flutter_ui/screens/my_profile.dart';
import 'package:http/http.dart' as http;
import 'package:localstore/localstore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'categories.dart';
import 'my_cart.dart';

class groceryMain extends StatefulWidget {
  LoginModel user;
  groceryMain(this.user);


  @override
  _groceryMainState createState() => _groceryMainState();
}

class _groceryMainState extends State<groceryMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late Product product= Product(allproducts: []);
  final _items = <String, Todo>{};


  @override
  void initState() {
    // TODO: implement initState
    getTokenToSP();
    GetProductsFromAPi();
   // getproductsMethod();
   // print(product.allproducts.first.name);print("1111111111111111111111111111111111111");
    super.initState();
  }


  final List<String> imageString = [
    'assets/images/bread.jpg',
    'assets/images/bread.jpg',
    'assets/images/bread.jpg',
    'assets/images/bread.jpg',  ];
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C'
  ];
  final List<int> colorCodes = <int>[
    600,
    500,
    100,
    600,
    500,
    100,
    600,
    500,
    100
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
      drawer: new Drawer(
        child: new ListView(
          children: [
            // header

            // Body
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Hey, Muhammad Haris"),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Categories())),
              child: ListTile(
                title: Text("Catogories"),
                leading: Icon(
                  Icons.scatter_plot_rounded,
                  color: Colors.grey,
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CartScreen())),
              child: ListTile(
                title: Text("My Cart"),
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () async{
                UserProfileModel? userInfo =  await userProfile(widget.user.token);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyProfile(userInfo!)));

              },
              child: ListTile(
                title: Text("info"),
                leading: Icon(
                  Icons.info,
                  color: Colors.teal[100],
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: ()=> exit(0),
              child: ListTile(
                title: Text("Logout"),
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        //App bar container
        child:
        product == null?
            CircularProgressIndicator()
        :

        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: (){
                        _scaffoldKey.currentState!.openDrawer();
                      },
                        child: Icon(Icons.storage, size: 34, color: Colors.green)),
                    SizedBox(
                      width: 15.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: 15.0,),
                        Text(
                          'Delievery location                                ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'User will select location',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Icon(Icons.edit, size: 18, color: Colors.black),
                    SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: ()  => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => CartScreen())),
                      child: Icon(Icons.add_shopping_cart,
                          size: 34, color: Colors.green),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                child: TextField(
                  // style: TextStyle(
                  //   fontSize: 15.0,
                  //   color: Colors.black,
                  // ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'What are you looking for',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      )),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.2,
                child: CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                  ),
                  items: imageString
                      .map((e) => ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Image.asset(
                                  e,
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Featured products',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      'View all >',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: product.allproducts.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width / 3,
                          margin: EdgeInsets.only(
                              bottom: 20.0, left: 10, right: 5.0),
                          decoration: BoxDecoration(
                            // color: Colors.amber[colorCodes[index]],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            // border: Border.all(width: 2.0, color: Colors.grey)
                            //Center(child: Text('Entry ${entries[index]}'))
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(top: 25),
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                            context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
                                        child:  Container(
                                          height: 150,
                                          child: Image(
                                            image: NetworkImage(product.allproducts[index].imageUrl),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        product.allproducts[index].name,
                                        // textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                         "Count ${product.allproducts[index].countInStock.toString()}",
                                        //  textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        product.allproducts[index].price.toString(),
                                        //  textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.green,
                                          //fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                       product.allproducts[index].price.toString(),
                                        //  textAlignTextAlign.start,
                                        style: TextStyle(
                                          fontSize: 10,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          //fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  FlatButton(
                                    minWidth:
                                    MediaQuery.of(context).size.width * 0.9,
                                    onPressed: ()async{

                                      final id = Localstore.instance.collection('todos').doc("ABC")
                                          .collection("cart").doc().id;
                                      final item = Todo(
                                        id: id,
                                        title: product.allproducts[index].name,
                                        price: product.allproducts[index].price.toString(),
                                        done: false,
                                        quantity: 1,
                                        imgUrl: product.allproducts[index].imageUrl,
                                        productId: product.allproducts[index].id,
                                        itemInStock: product.allproducts[index].countInStock,
                                      );
                                      ToastMsg(Colors.green, "Product Added to cart");
                                      item.save("ABC");
                                      _items.putIfAbsent(item.id, () => item);

                                    },
                                    child: Text('Add to cart',
                                        style: TextStyle(color: Colors.green)),
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(1)),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },),),






              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: GestureDetector(
                  // onTap: () => Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => ProductDetail())),
                  child: Image(
                    image: AssetImage(
                      'assets/images/bread.jpg',),
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        'Young People Buy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: product.allproducts.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(
                          bottom: 20.0, left: 10, right: 5.0),
                      decoration: BoxDecoration(
                        // color: Colors.amber[colorCodes[index]],
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0)),
                        // border: Border.all(width: 2.0, color: Colors.grey)
                        //Center(child: Text('Entry ${entries[index]}'))
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
                                    child:  Container(
                                      height: 150,
                                      child: Image(
                                        image: NetworkImage(product.allproducts[index].imageUrl),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    product.allproducts[index].name,
                                    // textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Count ${product.allproducts[index].countInStock.toString()}",
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    product.allproducts[index].price.toString(),
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    product.allproducts[index].price.toString(),
                                    //  textAlignTextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      decoration:
                                      TextDecoration.lineThrough,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              FlatButton(
                                minWidth:
                                MediaQuery.of(context).size.width * 0.9,
                                onPressed: ()async{

                                  final id = Localstore.instance.collection('todos').doc("ABC")
                                      .collection("cart").doc().id;
                                  final item = Todo(
                                    id: id,
                                    title: product.allproducts[index].name,
                                    price: product.allproducts[index].price.toString(),
                                    done: false,
                                    quantity: 1,
                                    imgUrl: product.allproducts[index].imageUrl,
                                    productId: product.allproducts[index].id,
                                    itemInStock: product.allproducts[index].countInStock,
                                  );
                                  ToastMsg(Colors.green, "Product Added to cart");
                                  item.save("ABC");
                                  _items.putIfAbsent(item.id, () => item);

                                },
                                child: Text('Add to cart',
                                    style: TextStyle(color: Colors.green)),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(1)),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },),),

              // Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height * 0.33,
              //     child: ListView.builder(
              //         padding: const EdgeInsets.all(5),
              //         itemCount: entries.length,
              //         scrollDirection: Axis.horizontal,
              //         itemBuilder: (BuildContext context, int index) {
              //           return Container(
              //             height: MediaQuery.of(context).size.height * 0.2,
              //             width: MediaQuery.of(context).size.width / 3,
              //             margin: EdgeInsets.only(
              //                 bottom: 20.0, left: 10, right: 5.0),
              //             decoration: BoxDecoration(
              //               // color: Colors.amber[colorCodes[index]],
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(20.0)),
              //               // border: Border.all(width: 2.0, color: Colors.grey)
              //               //Center(child: Text('Entry ${entries[index]}'))
              //             ),
              //             child: Stack(
              //               children: [
              //                 Column(
              //                   children: [
              //                     Container(
              //                         decoration: BoxDecoration(
              //                             border: Border(
              //                           right: BorderSide(
              //                               width: 1.0, color: Colors.grey),
              //                         )),
              //                         margin: EdgeInsets.only(top: 25),
              //                         child: GestureDetector(
              //                           // onTap: () => Navigator.push(
              //                           //     context, MaterialPageRoute(builder: (_) => ProductDetail())),
              //                           child: Image(
              //                               image: AssetImage(
              //                                 'assets/images/bakry_dairy.jpg',
              //                           )),
              //                         )),
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       'Cold drinks',
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 15,
              //                         color: Colors.black54,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 )
              //               ],
              //             ),
              //           );
              //         })),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dalin,Rice & Flour',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      'View all >',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: product.allproducts.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(
                          bottom: 20.0, left: 10, right: 5.0),
                      decoration: BoxDecoration(
                        // color: Colors.amber[colorCodes[index]],
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0)),
                        // border: Border.all(width: 2.0, color: Colors.grey)
                        //Center(child: Text('Entry ${entries[index]}'))
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
                                    child:  Container(
                                      height: 150,
                                      child: Image(
                                        image: NetworkImage(product.allproducts[index].imageUrl),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    product.allproducts[index].name,
                                    // textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Count ${product.allproducts[index].countInStock.toString()}",
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    product.allproducts[index].price.toString(),
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    product.allproducts[index].price.toString(),
                                    //  textAlignTextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      decoration:
                                      TextDecoration.lineThrough,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              FlatButton(
                                minWidth:
                                MediaQuery.of(context).size.width * 0.9,
                                onPressed: ()async{

                                  final id = Localstore.instance.collection('todos').doc("ABC")
                                      .collection("cart").doc().id;
                                  final item = Todo(
                                    id: id,
                                    title: product.allproducts[index].name,
                                    price: product.allproducts[index].price.toString(),
                                    done: false,
                                    quantity: 1,
                                    imgUrl: product.allproducts[index].imageUrl,
                                    productId: product.allproducts[index].id,
                                    itemInStock: product.allproducts[index].countInStock,
                                  );
                                  ToastMsg(Colors.green, "Product Added to cart");
                                  item.save("ABC");
                                  _items.putIfAbsent(item.id, () => item);

                                },
                                child: Text('Add to cart',
                                    style: TextStyle(color: Colors.green)),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(1)),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },),),

              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 30,
                  child: Row(
                    children: [
                      Text(
                        'Shop by catogories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        'Fruit and vegetable',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: product.allproducts.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(
                          bottom: 20.0, left: 10, right: 5.0),
                      decoration: BoxDecoration(
                        // color: Colors.amber[colorCodes[index]],
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0)),
                        // border: Border.all(width: 2.0, color: Colors.grey)
                        //Center(child: Text('Entry ${entries[index]}'))
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
                                    child:  Container(
                                      height: 150,
                                      child: Image(
                                        image: NetworkImage(product.allproducts[index].imageUrl),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    product.allproducts[index].name,
                                    // textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Count ${product.allproducts[index].countInStock.toString()}",
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    product.allproducts[index].price.toString(),
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    product.allproducts[index].price.toString(),
                                    //  textAlignTextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      decoration:
                                      TextDecoration.lineThrough,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              FlatButton(
                                minWidth:
                                MediaQuery.of(context).size.width * 0.9,
                                onPressed: ()async{

                                  final id = Localstore.instance.collection('todos').doc("ABC")
                                      .collection("cart").doc().id;
                                  final item = Todo(
                                    id: id,
                                    title: product.allproducts[index].name,
                                    price: product.allproducts[index].price.toString(),
                                    done: false,
                                    quantity: 1,
                                    imgUrl: product.allproducts[index].imageUrl,
                                    productId: product.allproducts[index].id,
                                    itemInStock: product.allproducts[index].countInStock,
                                  );
                                  ToastMsg(Colors.green, "Product Added to cart");
                                  item.save("ABC");
                                  _items.putIfAbsent(item.id, () => item);

                                },
                                child: Text('Add to cart',
                                    style: TextStyle(color: Colors.green)),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(1)),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },),),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        'Fresh meat',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: product.allproducts.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(
                          bottom: 20.0, left: 10, right: 5.0),
                      decoration: BoxDecoration(
                        // color: Colors.amber[colorCodes[index]],
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0)),
                        // border: Border.all(width: 2.0, color: Colors.grey)
                        //Center(child: Text('Entry ${entries[index]}'))
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
                                    child:  Container(
                                      height: 150,
                                      child: Image(
                                        image: NetworkImage(product.allproducts[index].imageUrl),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    product.allproducts[index].name,
                                    // textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Count ${product.allproducts[index].countInStock.toString()}",
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    product.allproducts[index].price.toString(),
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    product.allproducts[index].price.toString(),
                                    //  textAlignTextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      decoration:
                                      TextDecoration.lineThrough,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              FlatButton(
                                minWidth:
                                MediaQuery.of(context).size.width * 0.9,
                                onPressed: ()async{

                                  final id = Localstore.instance.collection('todos').doc("ABC")
                                      .collection("cart").doc().id;
                                  final item = Todo(
                                    id: id,
                                    title: product.allproducts[index].name,
                                    price: product.allproducts[index].price.toString(),
                                    done: false,
                                    quantity: 1,
                                    imgUrl: product.allproducts[index].imageUrl,
                                    productId: product.allproducts[index].id,
                                    itemInStock: product.allproducts[index].countInStock,
                                  );
                                  ToastMsg(Colors.green, "Product Added to cart");
                                  item.save("ABC");
                                  _items.putIfAbsent(item.id, () => item);

                                },
                                child: Text('Add to cart',
                                    style: TextStyle(color: Colors.green)),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(1)),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },),),
              // Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height * 0.28,
              //     child: ListView.builder(
              //         padding: const EdgeInsets.all(5),
              //         itemCount: entries.length,
              //         scrollDirection: Axis.horizontal,
              //         itemBuilder: (BuildContext context, int index) {
              //           return Container(
              //             height: MediaQuery.of(context).size.height * 0.2,
              //             width: MediaQuery.of(context).size.width / 3,
              //             margin: EdgeInsets.only(
              //                 bottom: 10.0, left: 10, right: 5.0),
              //             decoration: BoxDecoration(
              //               // color: Colors.amber[colorCodes[index]],
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(20.0)),
              //               // border: Border.all(width: 2.0, color: Colors.grey)
              //               //Center(child: Text('Entry ${entries[index]}'))
              //             ),
              //             child: Stack(
              //               children: [
              //                 Column(
              //                   children: [
              //                     Container(
              //                         decoration: BoxDecoration(
              //                             border: Border(
              //                                 //right: BorderSide(width: 1.0, color: Colors.grey),
              //                                 )),
              //                         margin: EdgeInsets.only(top: 25),
              //                         child: GestureDetector(
              //                           // onTap: () => Navigator.push(
              //                           //     context, MaterialPageRoute(builder: (_) => ProductDetail())),
              //                           child: Image(
              //                               image: AssetImage(
              //                                 'assets/images/instant_food.jpg',
              //                               )),
              //                         )),
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       'Fresh meat',
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 15,
              //                         color: Colors.black54,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 )
              //               ],
              //             ),
              //           );
              //         })),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        'Fish and Sea Food',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: product.allproducts.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(
                          bottom: 20.0, left: 10, right: 5.0),
                      decoration: BoxDecoration(
                        // color: Colors.amber[colorCodes[index]],
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0)),
                        // border: Border.all(width: 2.0, color: Colors.grey)
                        //Center(child: Text('Entry ${entries[index]}'))
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
                                    child:  Container(
                                      height: 150,
                                      child: Image(
                                        image: NetworkImage(product.allproducts[index].imageUrl),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    product.allproducts[index].name,
                                    // textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Count ${product.allproducts[index].countInStock.toString()}",
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    product.allproducts[index].price.toString(),
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    product.allproducts[index].price.toString(),
                                    //  textAlignTextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      decoration:
                                      TextDecoration.lineThrough,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              FlatButton(
                                minWidth:
                                MediaQuery.of(context).size.width * 0.9,
                                onPressed: ()async{

                                  final id = Localstore.instance.collection('todos').doc("ABC")
                                      .collection("cart").doc().id;
                                  final item = Todo(
                                    id: id,
                                    title: product.allproducts[index].name,
                                    price: product.allproducts[index].price.toString(),
                                    done: false,
                                    quantity: 1,
                                    imgUrl: product.allproducts[index].imageUrl,
                                    productId: product.allproducts[index].id,
                                    itemInStock: product.allproducts[index].countInStock,
                                  );
                                  ToastMsg(Colors.green, "Product Added to cart");
                                  item.save("ABC");
                                  _items.putIfAbsent(item.id, () => item);

                                },
                                child: Text('Add to cart',
                                    style: TextStyle(color: Colors.green)),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(1)),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },),),

              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 40,
              //     child: Row(
              //       children: [
              //         Text(
              //           'Grocery',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(5),
              //     itemCount: product.allproducts.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height * 0.2,
              //         width: MediaQuery.of(context).size.width / 3,
              //         margin: EdgeInsets.only(
              //             bottom: 20.0, left: 10, right: 5.0),
              //         decoration: BoxDecoration(
              //           // color: Colors.amber[colorCodes[index]],
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(20.0)),
              //           // border: Border.all(width: 2.0, color: Colors.grey)
              //           //Center(child: Text('Entry ${entries[index]}'))
              //         ),
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Container(
              //                     margin: EdgeInsets.only(top: 25),
              //                     child: GestureDetector(
              //                       onTap: () => Navigator.push(
              //                           context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
              //                       child:  Container(
              //                         height: 150,
              //                         child: Image(
              //                           image: NetworkImage(product.allproducts[index].imageUrl),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].name,
              //                       // textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Count ${product.allproducts[index].countInStock.toString()}",
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.green,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlignTextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         decoration:
              //                         TextDecoration.lineThrough,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 FlatButton(
              //                   minWidth:
              //                   MediaQuery.of(context).size.width * 0.9,
              //                   onPressed: ()async{
              //
              //                     final id = Localstore.instance.collection('todos').doc("ABC")
              //                         .collection("cart").doc().id;
              //                     final item = Todo(
              //                       id: id,
              //                       title: product.allproducts[index].name,
              //                       price: product.allproducts[index].price.toString(),
              //                       done: false,
              //                       quantity: 1,
              //                     );
              //                     ToastMsg(Colors.green, "Product Added to cart");
              //                     item.save("ABC");
              //                     _items.putIfAbsent(item.id, () => item);
              //
              //                   },
              //                   child: Text('Add to cart',
              //                       style: TextStyle(color: Colors.green)),
              //                   textColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       side: BorderSide(
              //                           color: Colors.grey,
              //                           width: 1,
              //                           style: BorderStyle.solid),
              //                       borderRadius: BorderRadius.circular(1)),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },),),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 40,
              //     child: Row(
              //       children: [
              //         Text(
              //           'Personal Care',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(5),
              //     itemCount: product.allproducts.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height * 0.2,
              //         width: MediaQuery.of(context).size.width / 3,
              //         margin: EdgeInsets.only(
              //             bottom: 20.0, left: 10, right: 5.0),
              //         decoration: BoxDecoration(
              //           // color: Colors.amber[colorCodes[index]],
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(20.0)),
              //           // border: Border.all(width: 2.0, color: Colors.grey)
              //           //Center(child: Text('Entry ${entries[index]}'))
              //         ),
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Container(
              //                     margin: EdgeInsets.only(top: 25),
              //                     child: GestureDetector(
              //                       onTap: () => Navigator.push(
              //                           context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
              //                       child:  Container(
              //                         height: 150,
              //                         child: Image(
              //                           image: NetworkImage(product.allproducts[index].imageUrl),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].name,
              //                       // textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Count ${product.allproducts[index].countInStock.toString()}",
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.green,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlignTextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         decoration:
              //                         TextDecoration.lineThrough,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 FlatButton(
              //                   minWidth:
              //                   MediaQuery.of(context).size.width * 0.9,
              //                   onPressed: ()async{
              //
              //                     final id = Localstore.instance.collection('todos').doc("ABC")
              //                         .collection("cart").doc().id;
              //                     final item = Todo(
              //                       id: id,
              //                       title: product.allproducts[index].name,
              //                       price: product.allproducts[index].price.toString(),
              //                       done: false,
              //                       quantity: 1,
              //                     );
              //                     ToastMsg(Colors.green, "Product Added to cart");
              //                     item.save("ABC");
              //                     _items.putIfAbsent(item.id, () => item);
              //
              //                   },
              //                   child: Text('Add to cart',
              //                       style: TextStyle(color: Colors.green)),
              //                   textColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       side: BorderSide(
              //                           color: Colors.grey,
              //                           width: 1,
              //                           style: BorderStyle.solid),
              //                       borderRadius: BorderRadius.circular(1)),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },),),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 40,
              //     child: Row(
              //       children: [
              //         Text(
              //           'Dry Fruits and Nuts',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(5),
              //     itemCount: product.allproducts.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height * 0.2,
              //         width: MediaQuery.of(context).size.width / 3,
              //         margin: EdgeInsets.only(
              //             bottom: 20.0, left: 10, right: 5.0),
              //         decoration: BoxDecoration(
              //           // color: Colors.amber[colorCodes[index]],
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(20.0)),
              //           // border: Border.all(width: 2.0, color: Colors.grey)
              //           //Center(child: Text('Entry ${entries[index]}'))
              //         ),
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Container(
              //                     margin: EdgeInsets.only(top: 25),
              //                     child: GestureDetector(
              //                       onTap: () => Navigator.push(
              //                           context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
              //                       child:  Container(
              //                         height: 150,
              //                         child: Image(
              //                           image: NetworkImage(product.allproducts[index].imageUrl),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].name,
              //                       // textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Count ${product.allproducts[index].countInStock.toString()}",
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.green,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlignTextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         decoration:
              //                         TextDecoration.lineThrough,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 FlatButton(
              //                   minWidth:
              //                   MediaQuery.of(context).size.width * 0.9,
              //                   onPressed: ()async{
              //
              //                     final id = Localstore.instance.collection('todos').doc("ABC")
              //                         .collection("cart").doc().id;
              //                     final item = Todo(
              //                       id: id,
              //                       title: product.allproducts[index].name,
              //                       price: product.allproducts[index].price.toString(),
              //                       done: false,
              //                       quantity: 1,
              //                     );
              //                     ToastMsg(Colors.green, "Product Added to cart");
              //                     item.save("ABC");
              //                     _items.putIfAbsent(item.id, () => item);
              //
              //                   },
              //                   child: Text('Add to cart',
              //                       style: TextStyle(color: Colors.green)),
              //                   textColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       side: BorderSide(
              //                           color: Colors.grey,
              //                           width: 1,
              //                           style: BorderStyle.solid),
              //                       borderRadius: BorderRadius.circular(1)),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },),),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 40,
              //     child: Row(
              //       children: [
              //         Text(
              //           'Home Care',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(5),
              //     itemCount: product.allproducts.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height * 0.2,
              //         width: MediaQuery.of(context).size.width / 3,
              //         margin: EdgeInsets.only(
              //             bottom: 20.0, left: 10, right: 5.0),
              //         decoration: BoxDecoration(
              //           // color: Colors.amber[colorCodes[index]],
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(20.0)),
              //           // border: Border.all(width: 2.0, color: Colors.grey)
              //           //Center(child: Text('Entry ${entries[index]}'))
              //         ),
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Container(
              //                     margin: EdgeInsets.only(top: 25),
              //                     child: GestureDetector(
              //                       onTap: () => Navigator.push(
              //                           context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
              //                       child:  Container(
              //                         height: 150,
              //                         child: Image(
              //                           image: NetworkImage(product.allproducts[index].imageUrl),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].name,
              //                       // textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Count ${product.allproducts[index].countInStock.toString()}",
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.green,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlignTextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         decoration:
              //                         TextDecoration.lineThrough,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 FlatButton(
              //                   minWidth:
              //                   MediaQuery.of(context).size.width * 0.9,
              //                   onPressed: ()async{
              //
              //                     final id = Localstore.instance.collection('todos').doc("ABC")
              //                         .collection("cart").doc().id;
              //                     final item = Todo(
              //                       id: id,
              //                       title: product.allproducts[index].name,
              //                       price: product.allproducts[index].price.toString(),
              //                       done: false,
              //                       quantity: 1,
              //                     );
              //                     ToastMsg(Colors.green, "Product Added to cart");
              //                     item.save("ABC");
              //                     _items.putIfAbsent(item.id, () => item);
              //
              //                   },
              //                   child: Text('Add to cart',
              //                       style: TextStyle(color: Colors.green)),
              //                   textColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       side: BorderSide(
              //                           color: Colors.grey,
              //                           width: 1,
              //                           style: BorderStyle.solid),
              //                       borderRadius: BorderRadius.circular(1)),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },),),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 40,
              //     child: Row(
              //       children: [
              //         Text(
              //           'Baby Care',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(5),
              //     itemCount: product.allproducts.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height * 0.2,
              //         width: MediaQuery.of(context).size.width / 3,
              //         margin: EdgeInsets.only(
              //             bottom: 20.0, left: 10, right: 5.0),
              //         decoration: BoxDecoration(
              //           // color: Colors.amber[colorCodes[index]],
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(20.0)),
              //           // border: Border.all(width: 2.0, color: Colors.grey)
              //           //Center(child: Text('Entry ${entries[index]}'))
              //         ),
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Container(
              //                     margin: EdgeInsets.only(top: 25),
              //                     child: GestureDetector(
              //                       onTap: () => Navigator.push(
              //                           context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
              //                       child:  Container(
              //                         height: 150,
              //                         child: Image(
              //                           image: NetworkImage(product.allproducts[index].imageUrl),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].name,
              //                       // textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Count ${product.allproducts[index].countInStock.toString()}",
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.green,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlignTextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         decoration:
              //                         TextDecoration.lineThrough,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 FlatButton(
              //                   minWidth:
              //                   MediaQuery.of(context).size.width * 0.9,
              //                   onPressed: ()async{
              //
              //                     final id = Localstore.instance.collection('todos').doc("ABC")
              //                         .collection("cart").doc().id;
              //                     final item = Todo(
              //                       id: id,
              //                       title: product.allproducts[index].name,
              //                       price: product.allproducts[index].price.toString(),
              //                       done: false,
              //                       quantity: 1,
              //                     );
              //                     ToastMsg(Colors.green, "Product Added to cart");
              //                     item.save("ABC");
              //                     _items.putIfAbsent(item.id, () => item);
              //
              //                   },
              //                   child: Text('Add to cart',
              //                       style: TextStyle(color: Colors.green)),
              //                   textColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       side: BorderSide(
              //                           color: Colors.grey,
              //                           width: 1,
              //                           style: BorderStyle.solid),
              //                       borderRadius: BorderRadius.circular(1)),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },),),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 40,
              //     child: Row(
              //       children: [
              //         Text(
              //           'Backery & Dairy',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(5),
              //     itemCount: product.allproducts.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height * 0.2,
              //         width: MediaQuery.of(context).size.width / 3,
              //         margin: EdgeInsets.only(
              //             bottom: 20.0, left: 10, right: 5.0),
              //         decoration: BoxDecoration(
              //           // color: Colors.amber[colorCodes[index]],
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(20.0)),
              //           // border: Border.all(width: 2.0, color: Colors.grey)
              //           //Center(child: Text('Entry ${entries[index]}'))
              //         ),
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Container(
              //                     margin: EdgeInsets.only(top: 25),
              //                     child: GestureDetector(
              //                       onTap: () => Navigator.push(
              //                           context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
              //                       child:  Container(
              //                         height: 150,
              //                         child: Image(
              //                           image: NetworkImage(product.allproducts[index].imageUrl),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].name,
              //                       // textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Count ${product.allproducts[index].countInStock.toString()}",
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.green,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlignTextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         decoration:
              //                         TextDecoration.lineThrough,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 FlatButton(
              //                   minWidth:
              //                   MediaQuery.of(context).size.width * 0.9,
              //                   onPressed: ()async{
              //
              //                     final id = Localstore.instance.collection('todos').doc("ABC")
              //                         .collection("cart").doc().id;
              //                     final item = Todo(
              //                       id: id,
              //                       title: product.allproducts[index].name,
              //                       price: product.allproducts[index].price.toString(),
              //                       done: false,
              //                       quantity: 1,
              //                     );
              //                     ToastMsg(Colors.green, "Product Added to cart");
              //                     item.save("ABC");
              //                     _items.putIfAbsent(item.id, () => item);
              //
              //                   },
              //                   child: Text('Add to cart',
              //                       style: TextStyle(color: Colors.green)),
              //                   textColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       side: BorderSide(
              //                           color: Colors.grey,
              //                           width: 1,
              //                           style: BorderStyle.solid),
              //                       borderRadius: BorderRadius.circular(1)),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },),),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 40,
              //     child: Row(
              //       children: [
              //         Text(
              //           'Beverages',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(5),
              //     itemCount: product.allproducts.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height * 0.2,
              //         width: MediaQuery.of(context).size.width / 3,
              //         margin: EdgeInsets.only(
              //             bottom: 20.0, left: 10, right: 5.0),
              //         decoration: BoxDecoration(
              //           // color: Colors.amber[colorCodes[index]],
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(20.0)),
              //           // border: Border.all(width: 2.0, color: Colors.grey)
              //           //Center(child: Text('Entry ${entries[index]}'))
              //         ),
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Container(
              //                     margin: EdgeInsets.only(top: 25),
              //                     child: GestureDetector(
              //                       onTap: () => Navigator.push(
              //                           context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
              //                       child:  Container(
              //                         height: 150,
              //                         child: Image(
              //                           image: NetworkImage(product.allproducts[index].imageUrl),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].name,
              //                       // textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Count ${product.allproducts[index].countInStock.toString()}",
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.green,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlignTextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         decoration:
              //                         TextDecoration.lineThrough,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 FlatButton(
              //                   minWidth:
              //                   MediaQuery.of(context).size.width * 0.9,
              //                   onPressed: ()async{
              //
              //                     final id = Localstore.instance.collection('todos').doc("ABC")
              //                         .collection("cart").doc().id;
              //                     final item = Todo(
              //                       id: id,
              //                       title: product.allproducts[index].name,
              //                       price: product.allproducts[index].price.toString(),
              //                       done: false,
              //                       quantity: 1,
              //                     );
              //                     ToastMsg(Colors.green, "Product Added to cart");
              //                     item.save("ABC");
              //                     _items.putIfAbsent(item.id, () => item);
              //
              //                   },
              //                   child: Text('Add to cart',
              //                       style: TextStyle(color: Colors.green)),
              //                   textColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       side: BorderSide(
              //                           color: Colors.grey,
              //                           width: 1,
              //                           style: BorderStyle.solid),
              //                       borderRadius: BorderRadius.circular(1)),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },),),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 40,
              //     child: Row(
              //       children: [
              //         Text(
              //           'Instant Food',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(5),
              //     itemCount: product.allproducts.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height * 0.2,
              //         width: MediaQuery.of(context).size.width / 3,
              //         margin: EdgeInsets.only(
              //             bottom: 20.0, left: 10, right: 5.0),
              //         decoration: BoxDecoration(
              //           // color: Colors.amber[colorCodes[index]],
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(20.0)),
              //           // border: Border.all(width: 2.0, color: Colors.grey)
              //           //Center(child: Text('Entry ${entries[index]}'))
              //         ),
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Container(
              //                     margin: EdgeInsets.only(top: 25),
              //                     child: GestureDetector(
              //                       onTap: () => Navigator.push(
              //                           context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
              //                       child:  Container(
              //                         height: 150,
              //                         child: Image(
              //                           image: NetworkImage(product.allproducts[index].imageUrl),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].name,
              //                       // textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Count ${product.allproducts[index].countInStock.toString()}",
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.green,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlignTextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         decoration:
              //                         TextDecoration.lineThrough,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 FlatButton(
              //                   minWidth:
              //                   MediaQuery.of(context).size.width * 0.9,
              //                   onPressed: ()async{
              //
              //                     final id = Localstore.instance.collection('todos').doc("ABC")
              //                         .collection("cart").doc().id;
              //                     final item = Todo(
              //                       id: id,
              //                       title: product.allproducts[index].name,
              //                       price: product.allproducts[index].price.toString(),
              //                       done: false,
              //                       quantity: 1,
              //                     );
              //                     ToastMsg(Colors.green, "Product Added to cart");
              //                     item.save("ABC");
              //                     _items.putIfAbsent(item.id, () => item);
              //
              //                   },
              //                   child: Text('Add to cart',
              //                       style: TextStyle(color: Colors.green)),
              //                   textColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       side: BorderSide(
              //                           color: Colors.grey,
              //                           width: 1,
              //                           style: BorderStyle.solid),
              //                       borderRadius: BorderRadius.circular(1)),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },),),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 40,
              //     child: Row(
              //       children: [
              //         Text(
              //           'Frozen and Chilled',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(5),
              //     itemCount: product.allproducts.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height * 0.2,
              //         width: MediaQuery.of(context).size.width / 3,
              //         margin: EdgeInsets.only(
              //             bottom: 20.0, left: 10, right: 5.0),
              //         decoration: BoxDecoration(
              //           // color: Colors.amber[colorCodes[index]],
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(20.0)),
              //           // border: Border.all(width: 2.0, color: Colors.grey)
              //           //Center(child: Text('Entry ${entries[index]}'))
              //         ),
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Container(
              //                     margin: EdgeInsets.only(top: 25),
              //                     child: GestureDetector(
              //                       onTap: () => Navigator.push(
              //                           context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
              //                       child:  Container(
              //                         height: 150,
              //                         child: Image(
              //                           image: NetworkImage(product.allproducts[index].imageUrl),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].name,
              //                       // textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Count ${product.allproducts[index].countInStock.toString()}",
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.green,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlignTextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         decoration:
              //                         TextDecoration.lineThrough,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 FlatButton(
              //                   minWidth:
              //                   MediaQuery.of(context).size.width * 0.9,
              //                   onPressed: ()async{
              //
              //                     final id = Localstore.instance.collection('todos').doc("ABC")
              //                         .collection("cart").doc().id;
              //                     final item = Todo(
              //                       id: id,
              //                       title: product.allproducts[index].name,
              //                       price: product.allproducts[index].price.toString(),
              //                       done: false,
              //                       quantity: 1,
              //                     );
              //                     ToastMsg(Colors.green, "Product Added to cart");
              //                     item.save("ABC");
              //                     _items.putIfAbsent(item.id, () => item);
              //
              //                   },
              //                   child: Text('Add to cart',
              //                       style: TextStyle(color: Colors.green)),
              //                   textColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       side: BorderSide(
              //                           color: Colors.grey,
              //                           width: 1,
              //                           style: BorderStyle.solid),
              //                       borderRadius: BorderRadius.circular(1)),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },),),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 40,
              //     child: Row(
              //       children: [
              //         Text(
              //           'OTC & Wellness',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(5),
              //     itemCount: product.allproducts.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height * 0.2,
              //         width: MediaQuery.of(context).size.width / 3,
              //         margin: EdgeInsets.only(
              //             bottom: 20.0, left: 10, right: 5.0),
              //         decoration: BoxDecoration(
              //           // color: Colors.amber[colorCodes[index]],
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(20.0)),
              //           // border: Border.all(width: 2.0, color: Colors.grey)
              //           //Center(child: Text('Entry ${entries[index]}'))
              //         ),
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Container(
              //                     margin: EdgeInsets.only(top: 25),
              //                     child: GestureDetector(
              //                       onTap: () => Navigator.push(
              //                           context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
              //                       child:  Container(
              //                         height: 150,
              //                         child: Image(
              //                           image: NetworkImage(product.allproducts[index].imageUrl),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].name,
              //                       // textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Count ${product.allproducts[index].countInStock.toString()}",
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.green,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlignTextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         decoration:
              //                         TextDecoration.lineThrough,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 FlatButton(
              //                   minWidth:
              //                   MediaQuery.of(context).size.width * 0.9,
              //                   onPressed: ()async{
              //
              //                     final id = Localstore.instance.collection('todos').doc("ABC")
              //                         .collection("cart").doc().id;
              //                     final item = Todo(
              //                       id: id,
              //                       title: product.allproducts[index].name,
              //                       price: product.allproducts[index].price.toString(),
              //                       done: false,
              //                       quantity: 1,
              //                     );
              //                     ToastMsg(Colors.green, "Product Added to cart");
              //                     item.save("ABC");
              //                     _items.putIfAbsent(item.id, () => item);
              //
              //                   },
              //                   child: Text('Add to cart',
              //                       style: TextStyle(color: Colors.green)),
              //                   textColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       side: BorderSide(
              //                           color: Colors.grey,
              //                           width: 1,
              //                           style: BorderStyle.solid),
              //                       borderRadius: BorderRadius.circular(1)),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },),),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 40,
              //     child: Row(
              //       children: [
              //         Text(
              //           'Pan Shop',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(5),
              //     itemCount: product.allproducts.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height * 0.2,
              //         width: MediaQuery.of(context).size.width / 3,
              //         margin: EdgeInsets.only(
              //             bottom: 20.0, left: 10, right: 5.0),
              //         decoration: BoxDecoration(
              //           // color: Colors.amber[colorCodes[index]],
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(20.0)),
              //           // border: Border.all(width: 2.0, color: Colors.grey)
              //           //Center(child: Text('Entry ${entries[index]}'))
              //         ),
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Container(
              //                     margin: EdgeInsets.only(top: 25),
              //                     child: GestureDetector(
              //                       onTap: () => Navigator.push(
              //                           context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
              //                       child:  Container(
              //                         height: 150,
              //                         child: Image(
              //                           image: NetworkImage(product.allproducts[index].imageUrl),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].name,
              //                       // textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Count ${product.allproducts[index].countInStock.toString()}",
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.green,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlignTextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         decoration:
              //                         TextDecoration.lineThrough,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 FlatButton(
              //                   minWidth:
              //                   MediaQuery.of(context).size.width * 0.9,
              //                   onPressed: ()async{
              //
              //                     final id = Localstore.instance.collection('todos').doc("ABC")
              //                         .collection("cart").doc().id;
              //                     final item = Todo(
              //                       id: id,
              //                       title: product.allproducts[index].name,
              //                       price: product.allproducts[index].price.toString(),
              //                       done: false,
              //                       quantity: 1,
              //                       imgUrl: product.allproducts[index].imageUrl,
              //                     );
              //                     ToastMsg(Colors.green, "Product Added to cart");
              //                     item.save("ABC");
              //                     _items.putIfAbsent(item.id, () => item);
              //
              //                   },
              //                   child: Text('Add to cart',
              //                       style: TextStyle(color: Colors.green)),
              //                   textColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       side: BorderSide(
              //                           color: Colors.grey,
              //                           width: 1,
              //                           style: BorderStyle.solid),
              //                       borderRadius: BorderRadius.circular(1)),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },),),
              // Container(
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: 40,
              //     child: Row(
              //       children: [
              //         Text(
              //           'Pet Care',
              //           style: TextStyle(
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height * 0.45,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(5),
              //     itemCount: product.allproducts.length,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height * 0.2,
              //         width: MediaQuery.of(context).size.width / 3,
              //         margin: EdgeInsets.only(
              //             bottom: 20.0, left: 10, right: 5.0),
              //         decoration: BoxDecoration(
              //           // color: Colors.amber[colorCodes[index]],
              //           borderRadius:
              //           BorderRadius.all(Radius.circular(20.0)),
              //           // border: Border.all(width: 2.0, color: Colors.grey)
              //           //Center(child: Text('Entry ${entries[index]}'))
              //         ),
              //         child: Stack(
              //           children: [
              //             Column(
              //               children: [
              //                 Container(
              //                     margin: EdgeInsets.only(top: 25),
              //                     child: GestureDetector(
              //                       onTap: () => Navigator.push(
              //                           context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
              //                       child:  Container(
              //                         height: 150,
              //                         child: Image(
              //                           image: NetworkImage(product.allproducts[index].imageUrl),
              //                           fit: BoxFit.fill,
              //                         ),
              //                       ),
              //                     )
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].name,
              //                       // textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       "Count ${product.allproducts[index].countInStock.toString()}",
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     SizedBox(
              //                       width: 5,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlign: TextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         color: Colors.green,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Text(
              //                       product.allproducts[index].price.toString(),
              //                       //  textAlignTextAlign.start,
              //                       style: TextStyle(
              //                         fontSize: 10,
              //                         decoration:
              //                         TextDecoration.lineThrough,
              //                         //fontWeight: FontWeight.bold
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 FlatButton(
              //                   minWidth:
              //                   MediaQuery.of(context).size.width * 0.9,
              //                   onPressed: ()async{
              //
              //                     final id = Localstore.instance.collection('todos').doc("ABC")
              //                         .collection("cart").doc().id;
              //                     final item = Todo(
              //                       id: id,
              //                       title: product.allproducts[index].name,
              //                       price: product.allproducts[index].price.toString(),
              //                       done: false,
              //                       quantity: 1,
              //                     );
              //                     ToastMsg(Colors.green, "Product Added to cart");
              //                     item.save("ABC");
              //                     _items.putIfAbsent(item.id, () => item);
              //
              //                   },
              //                   child: Text('Add to cart',
              //                       style: TextStyle(color: Colors.green)),
              //                   textColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       side: BorderSide(
              //                           color: Colors.grey,
              //                           width: 1,
              //                           style: BorderStyle.solid),
              //                       borderRadius: BorderRadius.circular(1)),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       );
              //     },),),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 5.0, color: Colors.black12),
                  bottom: BorderSide(width: 5.0, color: Colors.black12),
                )),
                child: Center(
                  child: Text(
                    'More to Love',
                    style: TextStyle(fontSize: 24, color: Colors.grey.shade500),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: product.allproducts.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width / 3,
                      margin: EdgeInsets.only(
                          bottom: 20.0, left: 10, right: 5.0),
                      decoration: BoxDecoration(
                        // color: Colors.amber[colorCodes[index]],
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0)),
                        // border: Border.all(width: 2.0, color: Colors.grey)
                        //Center(child: Text('Entry ${entries[index]}'))
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => ProductDetail(product,index))),
                                    child:  Container(
                                      height: 150,
                                      child: Image(
                                        image: NetworkImage(product.allproducts[index].imageUrl),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    product.allproducts[index].name,
                                    // textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Count ${product.allproducts[index].countInStock.toString()}",
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    product.allproducts[index].price.toString(),
                                    //  textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    product.allproducts[index].price.toString(),
                                    //  textAlignTextAlign.start,
                                    style: TextStyle(
                                      fontSize: 10,
                                      decoration:
                                      TextDecoration.lineThrough,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              FlatButton(
                                minWidth:
                                MediaQuery.of(context).size.width * 0.9,
                                onPressed: ()async{

                                  final id = Localstore.instance.collection('todos').doc("ABC")
                                      .collection("cart").doc().id;
                                  final item = Todo(
                                    id: id,
                                    title: product.allproducts[index].name,
                                    price: product.allproducts[index].price.toString(),
                                    done: false,
                                    quantity: 1,
                                    imgUrl: product.allproducts[index].imageUrl,
                                    productId: product.allproducts[index].id,
                                    itemInStock: product.allproducts[index].countInStock,
                                  );
                                  ToastMsg(Colors.green, "Product Added to cart");
                                  item.save("ABC");
                                  _items.putIfAbsent(item.id, () => item);

                                },
                                child: Text('Add to cart',
                                    style: TextStyle(color: Colors.green)),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(1)),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },),),

            ],
          ),
        ),
      ),
    );
  }

  Future<Product?> getproductsMethod() async {
    final String apiUrl = "https://new-apna-store.herokuapp.com/api/getproducts";

    // print("creatUserMethod Runs");

    final response = await http.get(Uri.parse(apiUrl));

    // print(response.statusCode);

    if (response.statusCode == 200) {
      final String responseString = response.body;

      // setState(() {
      //   product = response.body;
      // });
      return productFromJson(responseString);
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

  void getTokenToSP() async{
    final prefs = await SharedPreferences.getInstance();
    final myString =  prefs.getString('token');
  }

  GetProductsFromAPi() async {

    final Product? user = await getproductsMethod();

    setState(() {
      product = user!;
      // totalProductPrice = totalPaymentCalculateMethod();

    });
    if(product == null)
    {
      ToastMsg(Colors.red,"Something went Wrong,try again",);
    }
    else
    {

      // ToastMsg(Colors.green,"Login SUccessfull",);
      print("this is Tokan...............");
      print(product.allproducts.length);print("===============");print(product.allproducts.first.name);
      // Navigator.push(context, MaterialPageRoute(builder: (_)=>Home(_tokenModel)));
    }
  }


  Future<UserProfileModel?> userProfile(String token) async {
    final String apiUrl = "https://new-apna-store.herokuapp.com/api/getSingleCustomerProfile";

    print("GetProfile Method Runs");

    final response = await http.post(Uri.parse(apiUrl), headers: {
      "x-auth-token": token
    });

    print(response.statusCode);

    if (response.statusCode == 200) {

      var responseString = response.body;

      return userProfileModelFromJson(responseString);
    } else if(response.statusCode == 401) {
      ToastMsg(
        Colors.red,
        "Cannot fetch User Profile Data",
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
