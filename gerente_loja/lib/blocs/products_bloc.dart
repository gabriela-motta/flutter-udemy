import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloc extends BlocBase {
  final _productsController = BehaviorSubject<List>();

  Stream<List> get outCategories => _productsController.stream;

  List<DocumentSnapshot> _products = [];
  Firestore _firestore = Firestore.instance;

  ProductsBloc() {
    _addProductsListener();
  }

  void _addProductsListener() {
    _firestore.collection("products").snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String oid = change.document.documentID;
        switch (change.type) {
          case DocumentChangeType.added:
            _products.add(change.document);
            break;
          case DocumentChangeType.modified:
            _products.removeWhere((order) => order.documentID == oid);
            _products.add(change.document);
            break;
          case DocumentChangeType.removed:
            _products.removeWhere((order) => order.documentID == oid);
            break;
        }
      });
      _productsController.add(_products);
    });
  }

  @override
  void dispose() {
    _productsController.close();
  }
}
