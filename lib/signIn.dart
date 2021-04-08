import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type your email';
                  }
                },
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (input) => _email = input,
              ),
              TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return 'Your password needs to be atleast 6 characters';
                  }
                },
                decoration: InputDecoration(labelText: 'Password'),
                onSaved: (input) => _password = input,
                obscureText: true,
              ),
              RaisedButton(
                onPressed: signIn,
                child: Text('Sign in'),
              ),
            ],
          )),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    //Validate fields
    if (formState.validate()) {
      //Login to firebase
      formState.save();
      try {
        User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email, password: _password)) as User;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
