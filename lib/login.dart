import 'package:flutter/material.dart';
import 'package:fluttertask/home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginFormValidation extends StatefulWidget {
  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<LoginFormValidation> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool validateStructure(String value, String pattern) {
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  login() {
    if (password.text.trim() != "Fin@123" ||
        username.text.trim() != "Fininfocom") {
      Fluttertoast.showToast(msg: "Incorrect credentials");
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "* Required";
    } else if (value.length < 7) {
      return "Password should be atleast 7 characters";
    } else if (!validateStructure(value, r'[A-Z]')) {
      return "Password should have atleast 1 UpperCase Alphabet";
    } else if (!validateStructure(value, r'[0-9]')) {
      return "Password should have atleast 1 Numeric character";
    } else if (!validateStructure(value, r'[!@#\$&*~]')) {
      return "Password should have atleast 1 Special character";
    } else {
      return null;
    }
  }

  String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return "* Required";
    } else if (value.length != 10) {
      return "Username must be 10 characters";
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode
              .onUserInteraction, //check for validation while typing
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/logo.png')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      hintText: 'Enter vald username'),
                  validator: validateUsername,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    validator: validatePassword,
                    //validatePassword,        //Function to check validation
                  )),
              // ElevatedButton(
              //   onPressed: () {
              //     //TODO FORGOT PASSWORD SCREEN GOES HERE
              //   },
              //   child: Text(
              //     'Forgot Password',
              //     style: TextStyle(color: Colors.blue, fontSize: 15),
              //   ),
              // ),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      login();
                      print("Validated");
                    } else {
                      print("Not Validated");
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
