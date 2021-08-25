// To parse this JSON data, do
//
//     final orderPlaceMsgModel = orderPlaceMsgModelFromJson(jsonString);

import 'dart:convert';

OrderPlaceMsgModel orderPlaceMsgModelFromJson(String str) => OrderPlaceMsgModel.fromJson(json.decode(str));

String orderPlaceMsgModelToJson(OrderPlaceMsgModel data) => json.encode(data.toJson());

class OrderPlaceMsgModel {
  OrderPlaceMsgModel({
    required this.message,
    required this.order,
  });

  String message;
  Order order;

  factory OrderPlaceMsgModel.fromJson(Map<String, dynamic> json) => OrderPlaceMsgModel(
    message: json["message"],
    order: Order.fromJson(json["order"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "order": order.toJson(),
  };
}

class Order {
  Order({
    required this.id,
    required this.orderItems,
    required this.itemsPrice,
    required this.user,
    required this.totalPrice,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  List<OrderItem> orderItems;
  int itemsPrice;
  String user;
  int totalPrice;
  String orderStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["_id"],
    orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
    itemsPrice: json["itemsPrice"],
    user: json["user"],
    totalPrice: json["totalPrice"],
    orderStatus: json["orderStatus"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
    "itemsPrice": itemsPrice,
    "user": user,
    "totalPrice": totalPrice,
    "orderStatus": orderStatus,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class OrderItem {
  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.qty,
    required this.countInStock,
    required this.product,
  });

  String id;
  String name;
  int price;
  String imageUrl;
  int qty;
  int countInStock;
  String product;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["_id"],
    name: json["name"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    qty: json["qty"],
    countInStock: json["countInStock"],
    product: json["product"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "price": price,
    "imageUrl": imageUrl,
    "qty": qty,
    "countInStock": countInStock,
    "product": product,
  };
}
