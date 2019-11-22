import 'package:flutter/material.dart';
import 'package:gerente_loja/widgets/add_size_dialog.dart';

class ProductSizes extends FormField<List> {
  ProductSizes({
    BuildContext context,
    List initialValue,
    FormFieldSetter<List> onSaved,
    FormFieldValidator<List> validator,
  }) : super(
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          builder: (state) {
            if (initialValue == null) {
              return SizedBox(
                height: 0,
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Tamanhos",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 34,
                    child: GridView(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.5,
                      ),
                      children: state.value.map(
                        (s) {
                          return GestureDetector(
                            onLongPress: () {
                              state.didChange(state.value..remove(s));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                border: Border.all(
                                  color: Colors.redAccent[700],
                                  width: 3,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                s,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ).toList()
                        ..add(
                          GestureDetector(
                            onTap: () async {
                              String size = await showDialog(
                                context: context,
                                builder: (context) => AddSizeDialog(),
                              );
                              if (size != null)
                                state.didChange(state.value..add(size));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "+",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                    ),
                  ),
                ],
              );
            }
          },
        );
}
