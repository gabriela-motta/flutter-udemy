import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loja/models/cart_model.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                title: "SuperGeeks",
                theme: ThemeData(
                    accentColor: Color.fromARGB(255, 127, 0, 0),
                    primarySwatch: Colors.red,
                    primaryColor: Color.fromARGB(255, 127, 0, 0)),
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
              ),
            );
          },
        ));
  }
}
