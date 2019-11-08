import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryTile extends StatelessWidget {
  final Map<String, dynamic> category;

  CategoryTile(this.category);

  Widget productTile() {
    for (var prod in category["items"]) {
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(prod["images"][0]),
        ),
        title: Text(prod["title"]),
        trailing: Text("R\$${prod["price"].toStringAsFixed(2)}"),
        onTap: () {},
      );
    }
  }

  Widget productsColumn() {
    if (category.containsKey("items")) {
      print(category["items"][0]["price"]);
      return Column(
        children: <Widget>[
          productTile(),
        ],
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 20,
              child: Shimmer.fromColors(
                child: Container(
                  color: Colors.white.withAlpha(50),
                  margin: EdgeInsets.symmetric(vertical: 4),
                ),
                baseColor: Colors.white,
                highlightColor: Colors.grey[900],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: Card(
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(category["icon"]),
            backgroundColor: Colors.transparent,
          ),
          title: Text(
            "${category["title"]}",
            style: TextStyle(color: Colors.black),
          ),
          children: <Widget>[
            productsColumn(),
          ],
        ),
      ),
    );
  }
}
