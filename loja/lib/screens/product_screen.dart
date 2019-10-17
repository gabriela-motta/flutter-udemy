import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja/data/cart_product_data.dart';
import 'package:loja/data/product_data.dart';
import 'package:loja/models/cart_model.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  String size;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    List<GestureDetector> getProductSizes() {
      return product.sizes.map((s) {
        return GestureDetector(
          onTap: () {
            setState(() {
              size = s;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(
                color: s == size ? primaryColor : Colors.grey[500],
                width: 3,
              ),
              color: s == size ? primaryColor : Colors.transparent,
            ),
            width: 50,
            alignment: Alignment.center,
            child: Text(
              s,
              style: TextStyle(
                color: s == size ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList();
    }

    Widget productSize() {
      if (product.sizes != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Tamanho",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 34,
              child: GridView(
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                ),
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.5,
                ),
                children: getProductSizes(),
              ),
            ),
          ],
        );
      } else {
        return SizedBox(
          height: 0,
        );
      }
    }

    Widget productDescription() {
      if (product.description != null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Descrição",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        );
      } else {
        return SizedBox(
          height: 0,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 16,
                ),
                productSize(),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    color: primaryColor,
                    textColor: Colors.white,
                    child: Text(
                      UserModel.of(context).isLoggedIn()
                          ? "Adicionar ao carrinho"
                          : "Entre para comprar",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onPressed: (product.sizes == null || size != null)
                        ? () {
                            if (UserModel.of(context).isLoggedIn()) {
                              CartProductData cartProduct = CartProductData();
                              cartProduct.size = size;
                              cartProduct.quantity = 1;
                              cartProduct.pid = product.id;
                              cartProduct.category = product.category;
                              CartModel.of(context).addCartItem(cartProduct);
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                            }
                          }
                        : null,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                productDescription(),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          ),
        ],
      ),
    );
  }
}
