import 'package:flutter/material.dart';
import 'package:scan_app/pages/home_page.dart';
import 'package:scan_app/pages/login_page.dart';
import 'package:scan_app/utils/custom_firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Editing Controllers
    const signUpLogo = CircleAvatar(
      radius: 102,
      backgroundColor: Colors.blue,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/signUp.png'),
        radius: 100,
      ),
    );
    final nameField = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Name can't be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Minimum of 3 characters Required");
        }
        return null;
      },
      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Name",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_rounded),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password can't be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Minimum 6 characters Required");
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Passcode",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final cpasswordField = TextFormField(
      autofocus: false,
      controller: cpasswordController,
      obscureText: true,
      validator: (value) {
        if (passwordController.text != cpasswordController.text) {
          return ("Passcode doesn't match");
        }
        return null;
      },
      onSaved: (value) {
        cpasswordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Passcode",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailController.text, passwordController.text);
        },
        child: const Text(
          'Sign Up',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ),
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
                  signUpLogo,
                  const SizedBox(height: 40),
                  nameField,
                  const SizedBox(height: 40),
                  emailField,
                  const SizedBox(height: 40),
                  passwordField,
                  const SizedBox(height: 40),
                  cpasswordField,
                  const SizedBox(height: 40),
                  signUpButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String passcode) async {
    if (_formKey.currentState!.validate()) {
      CustomFirebaseAuth.signUp(email, passcode, nameController.text).then((_) {
        Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
      });
    }
  }
}
