import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja/data/post_data.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Color.fromARGB(255, 183, 28, 28)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("home")
                  .orderBy("pos")
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                } else {
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    staggeredTiles: snapshot.data.documents.map((doc) {
                      return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                    }).toList(),
                    children: snapshot.data.documents.map((doc) {
                      return FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: doc.data["image"],
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  );
                }
              },
            )
          ],
        )
      ],
    );
  }

  Future<Post> fetchPosts() async {
    final response = await http.get('https://instagram.com/supergeeksjp/');
    print(response.body.indexOf("window._sharedData"));
    print(response.body.substring(19001,36469));

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return Post.fromJson(json.decode(response.body.substring(19001,36469)));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
