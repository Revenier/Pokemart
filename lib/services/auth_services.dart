// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthServices {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   Future<UserCredential> signInWithEmailAndPassword(String  email, String password) async {
//     try{
//       //sign in
//       UserCredential usercredential =
//       await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//       return usercredential;
//     }
//     on FirebaseAuthException catch (e){
//       throw Exception(e.code);
//     }
//   }
// }