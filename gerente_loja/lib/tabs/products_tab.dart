import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/category_bloc.dart';
import 'package:gerente_loja/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    return StreamBuilder<List>(
      stream: _categoryBloc.outCategories,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(primaryColor),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return CategoryTile(snapshot.data[index]);
              },
            ),
          );
        }
      },
    );
  }
}
