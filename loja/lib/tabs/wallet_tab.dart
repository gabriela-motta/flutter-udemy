import 'package:flutter/material.dart';

class WalletTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 40, 10, 40),
          child: Text(
            "Seu saldo é R\$ 100,00",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(15),
        ),
        Container(
          child: Text(
            "Selecione um valor para fazer uma recarga:",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        ),
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'R\$ 10,00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: primaryColor,
                  alignment: Alignment.center,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'R\$ 20,00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: primaryColor,
                  alignment: Alignment.center,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'R\$ 50,00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: primaryColor,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
