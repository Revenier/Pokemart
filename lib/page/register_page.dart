import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/My%20Widget/MyButton.dart';
import 'package:frontend/My%20Widget/MyTextField.dart';
import 'package:frontend/My%20Widget/add_data.dart';
import 'package:frontend/My%20Widget/bgwidget.dart';
import 'package:frontend/page/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  var role = 'User';

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name must be filled!';
    }
    // You can add more password validation logic if needed
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email must be filled!';
    }
    if (!value.endsWith('@gmail.com')) {
      return 'Email Must be end with @gmail.com';
    }
    // You can add more email validation logic if needed
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password must be filled!';
    }
    if (value.length < 6) {
      return 'Password must be 6 character';
    }
    // You can add more password validation logic if needed
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return bgWidget(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // -- Sign Up
                    SizedBox(
                      height: height * 0.35,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),

                    // -- name
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: MyTextField(
                        controller: nameController,
                        TextHint: 'Name',
                        secureText: false,
                        unlockText: true,
                        line: 1,
                        validator: validateName,
                      ),
                    ),

                    // // -- username
                    // SizedBox(height: height*0.02,),
                    // Container(
                    //   margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    //   child: MyTextField(
                    //       controller: username,
                    //       TextHint: 'Username',
                    //       secureText: false
                    //   ),
                    // ),

                    // -- email
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: MyTextField(
                        controller: emailController,
                        TextHint: 'Email',
                        secureText: false,
                        unlockText: true,
                        line: 1,
                        validator: validateEmail,
                      ),
                    ),

                    // --> Password
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: MyTextField(
                        controller: passwordController,
                        TextHint: 'Password',
                        secureText: true,
                        unlockText: true,
                        line: 1,
                        validator: validatePassword,
                      ),
                    ),

                    // -- Google + login button
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: GestureDetector(
                          child: Container(
                            width: width * 0.3,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Image.asset('asset/Logo/icongoogle.png'),
                          ),
                          onTap: () {},
                        )),
                        SizedBox(
                          width: width * 0.07,
                        ),
                        Center(
                          child: MyButton(
                            onTap: () {
                              signUp(nameController.text, emailController.text,
                                  passwordController.text, role);
                            },
                            buttonColor: Colors.blue,
                            Text_on_button: 'Register',
                            sizeX: 0.3,
                          ),
                        ),
                      ],
                    ),

                    // -- create acc button
                    SizedBox(
                      height: height * 0.03,
                    ),
                    GestureDetector(
                      child: const Text("Have an account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              decoration: TextDecoration.underline)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void signUp(String name, String email, String password, String role) async {
    // Display a loading indicator
    // CircularProgressIndicator();

    if (_formKey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        postDetailsToFirestore(name, email, role,password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        print('User signed up successfully');
      } catch (e) {
        String errorMessage = 'An error occurred during sign up.';

        if (e is FirebaseAuthException) {
          if (e.code == 'weak-password') {
            errorMessage = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            errorMessage = 'The account already exists for that email.';
          } else {
            errorMessage = 'Error code: ${e.code}';
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }
  //
  // postDetailsToFirestore(String name, String email, String role) async {
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   var user = _auth.currentUser;
  //   CollectionReference ref = FirebaseFirestore.instance.collection('account');
  //   ref.doc(user!.uid).set({
  //     'name': nameController.text,
  //     'email': emailController.text,
  //     'role': role
  //   });
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => LoginPage()));
  //
  // }

}
