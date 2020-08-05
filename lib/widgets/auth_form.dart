import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    Key key,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPw = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      //TODO: Submit the form, talk to firebase
      _formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(
                    'images/logo.png',
                    width: 94,
                    height: 94,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          key: ValueKey('email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty || !value.contains("@")) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            this._userEmail = value;
                          },
                          decoration:
                              InputDecoration(labelText: 'Email address'),
                        ),
                        if (!this._isLogin)
                          TextFormField(
                            key: ValueKey('username'),
                            validator: (value) {
                              if (value.isEmpty || value.length < 4) {
                                return 'Min 4 characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              this._userName = value;
                            },
                            decoration: InputDecoration(labelText: 'Username'),
                          ),
                        TextFormField(
                          key: ValueKey('pw'),
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty || value.length < 7) {
                              return 'Password is too short.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            this._userPw = value;
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        RaisedButton(
                          onPressed: this._trySubmit,
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            this._isLogin ? "Login" : "Signup",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              this._isLogin = !this._isLogin;
                            });
                          },
                          child: Text(
                            this._isLogin
                                ? "Create new account"
                                : "Login with exsisting account",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
