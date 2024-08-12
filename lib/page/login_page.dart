import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/My%20Widget/MyButton.dart';
import 'package:frontend/My%20Widget/MyTextField.dart';
import 'package:frontend/My%20Widget/add_data.dart';
import 'package:frontend/Page_admin/profile_admin.dart';
import 'package:frontend/Page_user/NavigationBar.dart';
import 'package:frontend/My%20Widget/bgwidget.dart';
import 'package:frontend/page/register_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late GoogleSignInAccount Account;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email must be filled!';
    }
    if(!value.endsWith('@gmail.com')){
      return 'Email must be end with @gmail.com';
    }
    // You can add more email validation logic if needed
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password must be filled!';
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    child: Column(
                      children: [
                        // -- Sign In
                        SizedBox(height: height*0.32,),
                        Text("Sign In", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),
                        SizedBox(height: height*0.05,),

                        // -- Username
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

                        // -- password
                        SizedBox(height: height*0.02,),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: MyTextField(
                            controller: passwordController,
                            TextHint: 'password',
                            secureText: true,
                            unlockText: true,
                            line: 1,
                            validator: validatePassword ,
                          ),
                        ),

                        // -- Google + login button
                        SizedBox(height: height*0.05,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: GestureDetector(
                                  child: Container(
                                    width: width*0.3,
                                    height: height*0.05,
                                    decoration: BoxDecoration(
                                        color: Colors.white,

                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Image.asset('asset/Logo/icongoogle.png'),
                                  ),
                                  onTap: ()async {
                                    UserCredential? userCredential = await signInWithGoogle();
                                    if (userCredential != null) {
                                      postDetailsToFirestore(Account.displayName.toString(), Account.email.toString(), 'User','');
                                      print("Successfully signed in with Google: ${userCredential.user!.displayName}");
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavBar(index: 0,)));
                                    } else {
                                      print("Google Sign-In failed");
                                    }
                                  },
                                )
                            ),
                            SizedBox(width: width*0.07,),
                            Center(
                              child: MyButton(
                                onTap: (){
                                  signIn(emailController.text,
                                      passwordController.text);
                                },
                                buttonColor: Colors.blue,
                                Text_on_button: 'Login',
                                sizeX: 0.3,
                              ),
                            ),

                          ],
                        ),

                        // -- create acc button
                        SizedBox(height: height*0.05,),
                        GestureDetector(
                          child: const Text("Create Account",  style: TextStyle(color: Colors.black, fontSize: 16, decoration: TextDecoration.underline)),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('account')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "Admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  MainProfileAdmin(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  BottomNavBar(index: 0),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()){
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An unexpected error occurred.';
        if (e.code == 'user-not-found') {
          errorMessage = 'No account found for that email';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Invalid password';
        } else {
          errorMessage = 'Invalid email or password';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red, // Set the background color to red
            ),
          );
        }
      }
    }
  }


  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      Account=googleUser;
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
      return null;
    }
  }

}