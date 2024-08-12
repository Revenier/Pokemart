import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/My%20Widget/take_data.dart';

Future<void> postPokemonToFirestore(String id, String name, String desc, double value,String? selectedValue1, String? selectedValue2 ) async {
  try {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference ref = FirebaseFirestore.instance.collection('pokemon');

    if (id.length == 4 && id.startsWith('0')) {
      id = id.substring(1);
    }

    String imageUrl = 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/$id.png';

    ref.doc(id).set({
      'id':id,
      'name': name,
      'image': imageUrl,
      'element1' : selectedValue1,
      'element2' : selectedValue2,
      'desc': desc,
      'price': value,
    });
  } catch (e) {
    print("Error posting details to Firestore: $e");
  }
}
//
Future<void> postTransactionToFirestore(String userName, String userEmail, String PokeName, String PokeID, String image, double price) async {
  try {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference ref = FirebaseFirestore.instance.collection('transaction');

    int? id = (await getTransactionID())! + 1;
    String transID = 'TR${(id ?? 0 + 1).toString().padLeft(3, '0')}';

    ref.doc(transID).set({
      'id':id,
      'User Name': userName,
      'User Email': userEmail,
      'Pokemon Name' : PokeName,
      'PokeID' : PokeID,
      'image' : image,
      'price' : price
    });
  } catch (e) {
    print("Error posting details to Firestore: $e");
  }
}

postDetailsToFirestore(String name, String email, String role,String pass ) async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  CollectionReference ref = FirebaseFirestore.instance.collection('account');
  ref.doc(user!.uid).set({
    'name': name,
    'email': email,
    'role': role,
    'pw':pass
  });
}