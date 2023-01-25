import 'package:flutter/material.dart';
import 'package:scan_app/pages/home_page.dart';
import 'package:scan_app/pages/signUp_page.dart';
import 'package:scan_app/utils/custom_firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const logo = CircleAvatar(
      radius: 105,
      backgroundColor: Colors.green,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/loginImage.png'),
        radius: 100,
      ),
    );
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter a password");
        }
        if (!regex.hasMatch(value)) {
          return ("Minimum of six characters Required");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Passcode",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final signIn = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            logIn(emailController.text, passwordController.text);
          },
          child: const Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    const textOption = Text(
      'Dont have an account?',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
    );
    final signUp = Material(
      color: Colors.white,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(0, 15, 20, 15),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpPage()),
          );
        },
        child: const Text(
          'Sign Up',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  logo,
                  const SizedBox(height: 40),
                  emailField,
                  const SizedBox(height: 40),
                  passwordField,
                  const SizedBox(height: 40),
                  signIn,
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textOption,
                      signUp,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //login function
  void logIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      CustomFirebaseAuth.login(email, password).then((value) {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    }
  }
}
