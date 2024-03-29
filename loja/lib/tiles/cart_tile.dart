import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/data/cart_product_data.dart';
import 'package:loja/data/product_data.dart';
import 'package:loja/models/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProductData product;

  CartTile(this.product);
  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      CartModel.of(context).updatePrices();
      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: 120,
            child: Image.network(
              product.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    product.productData.title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    product.size != null ? "Tamanho ${product.size}" : "",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "R\$ ${product.productData.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                        onPressed: product.quantity > 1
                            ? () {
                                CartModel.of(context).decProduct(product);
                              }
                            : null,
                      ),
                      Text(product.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          CartModel.of(context).incProduct(product);
                        },
                      ),
                      FlatButton(
                        child: Text("Remover"),
                        textColor: Colors.grey[500],
                        onPressed: () {
                          CartModel.of(context).removeCartItem(product);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
        margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: product.productData == null
            ? FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection("products")
                    .document(product.category)
                    .collection("items")
                    .document(product.pid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    product.productData =
                        ProductData.fromDocument(snapshot.data);
                    return _buildContent();
                  } else {
                    return Container(
                      height: 70,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                },
              )
            : _buildContent());
  }
}
