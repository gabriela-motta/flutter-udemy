import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {
  final _categoryController = BehaviorSubject<List>();

  Stream<List> get outCategories => _categoryController.stream;

  Map<String, Map<String, dynamic>> _categories = {};
  Firestore _firestore = Firestore.instance;

  CategoryBloc() {
    _addProductsListener();
  }

  void _addProductsListener() {
    _firestore.collection("products").snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String cid = change.document.documentID;
        switch (change.type) {
          case DocumentChangeType.added:
            _categories[cid] = change.document.data;
            _subscribeToItems(cid);
            break;
          case DocumentChangeType.modified:
            _categories[cid].addAll(change.document.data);
            _categoryController.add(_categories.values.toList());
            break;
          case DocumentChangeType.removed:
            _categories.remove(cid);
            _unsubscribeToItems(cid);
            _categoryController.add(_categories.values.toList());
            break;
        }
      });
    });
  }

  void _subscribeToItems(String cid) {
    _categories[cid]["subscription"] = _firestore
        .collection("products")
        .document(cid)
        .collection("items")
        .snapshots()
        .listen((products) async {
      List items = products.documents;

      items.map((item) {
        item = {
          "title": item.data["title"],
          "price": item.data["price"],
          "sizes": item.data["sizes"],
          "description": item.data["description"],
          "images": item.data["images"],
        };
      });

      _categories[cid].addAll({"cid": cid, "items": items});

      _categoryController.add(_categories.values.toList());
    });
  }

  void _unsubscribeToItems(String cid) {
    _categories[cid]["subscription"].cancel();
  }

  @override
  void dispose() {
    _categoryController.close();
  }
}
