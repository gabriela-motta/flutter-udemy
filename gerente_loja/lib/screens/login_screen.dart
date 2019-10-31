import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/login_bloc.dart';
import 'package:gerente_loja/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/supergeeks-icon.png'),
                    height: 100,
                    width: 100,
                  ),
                  InputField(
                    icon: Icons.person_outline,
                    obscure: false,
                    hint: "Usuário",
                    stream: _loginBloc.outEmail,
                    onChanged: _loginBloc.changeEmail,
                  ),
                  InputField(
                    icon: Icons.lock_outline,
                    obscure: true,
                    hint: "Senha",
                    stream: _loginBloc.outPassword,
                    onChanged: _loginBloc.changePassword,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  StreamBuilder<bool>(
                    stream: _loginBloc.outSubmitValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        height: 50,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(140),
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onPressed: snapshot.hasData ? () {} : null,
                          textColor: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
