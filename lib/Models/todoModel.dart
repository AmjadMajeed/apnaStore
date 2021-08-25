import 'package:localstore/localstore.dart';

/// Data Model
class Todo {
  final String id;
  String title;
  // DateTime time;
  bool done;
  String price;
  int quantity;
  String imgUrl;
  String productId;
  String itemInStock;
  Todo({
    required this.id,
    required this.title,
    // this.time,
    required this.done,
    required this.price,
    required this.quantity,
    required this.imgUrl,
    required this.productId,
    required this.itemInStock,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      // 'time': time.millisecondsSinceEpoch,
      'done': done,
      'price': price,
      'quantity': quantity,
      'imgUrl': imgUrl,
      'productId': productId,
      'itemInStock': itemInStock
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      // time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      done: map['done'],
      price: map['price'],
      quantity: map['quantity'],
      imgUrl: map['imgUrl'],
      productId: map['productId'],
      itemInStock: map['itemInStock'],
    );
  }
}

extension ExtTodo on Todo {
  Future save(String first) async {
    print("Save method");
    print(quantity);
    final _db = Localstore.instance;
    return _db.collection('todos').doc(first).collection("cart").doc(id).set(toMap());
  }

  Future delete(String first) async {
    final _db = Localstore.instance;
    return _db.collection('todos').doc(first).collection("cart").doc(id).delete();
  }
}