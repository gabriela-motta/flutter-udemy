import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja/data/product_data.dart';

class CartProductData {
  String cid;
  String category;
  String pid;
  int quantity;
  String size;
  ProductData productData;

  CartProductData();

  CartProductData.fromDocument(DocumentSnapshot snapshot) {
    cid = snapshot.documentID;
    category = snapshot.data["category"];
    pid = snapshot.data["pid"];
    quantity = snapshot.data["quantity"];
    size = snapshot.data["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      //"product": productData.toResumedMap(),
    };
  }
}
