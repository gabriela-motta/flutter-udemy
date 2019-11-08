import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloc extends BlocBase {
  final _productsController = BehaviorSubject<List>();

  Stream<List> get outProducts => _productsController.stream;

  Map<String, Map<String, dynamic>> _products = {};
  Firestore _firestore = Firestore.instance;

  ProductsBloc() {
    _addProductsListener();
  }

  void _addProductsListener() {
    _firestore.collection("products").snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String cid = change.document.documentID;
        print(cid);
        switch (change.type) {
          case DocumentChangeType.added:
            _products[cid] = change.document.data;
            _subscribeToItems(cid);
            break;
          case DocumentChangeType.modified:
            _products[cid].addAll(change.document.data);
            _productsController.add(_products.values.toList());
            break;
          case DocumentChangeType.removed:
            _products.remove(cid);
            _unsubscribeToItems(cid);
            _productsController.add(_products.values.toList());
            break;
        }
      });
    });
  }

  void _subscribeToItems(String cid) {
    _products[cid]["subscription"] = _firestore
        .collection("products")
        .document(cid)
        .collection("items")
        .snapshots()
        .listen((products) async {
      int size = products.documents.length;
      List items = products.documents;

      items.map((item){
        item = {
          "title": item.data["title"],
          "price": item.data["price"],
          "sizes": item.data["sizes"],
          "description": item.data["description"],
          "images": item.data["images"],
        };
      });

      _products[cid].addAll({"size": size, "items": items});

      _productsController.add(_products.values.toList());
    });
  }

  void _unsubscribeToItems(String cid) {
    _products[cid]["subscription"].cancel();
  }

  @override
  void dispose() {
    _productsController.close();
  }
}
