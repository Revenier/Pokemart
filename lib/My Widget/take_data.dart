
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/My%20Widget/Model.dart';

Future<String?> takeData(String dataNeeded) async {
  User? user = FirebaseAuth.instance.currentUser;
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("account")
        .doc(user!.uid)
        .get();

    if (documentSnapshot.exists) {
      return documentSnapshot.get(dataNeeded).toString();
    } else {
      return null;
    }
  } catch (e) {
    print("Error fetching data: $e");
    return null;
  }
}


Future<List<PokeModel>> getAllPokemon() async {
  List<PokeModel> pokeList = [];

  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('pokemon').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      pokeList.add(PokeModel.fromDocumentSnapshot(doc));
    }
  } catch (e) {
    print("Error getting data: $e");
  }

  return pokeList;
}


Future<List<elementModel>> getElement() async {
  List<elementModel> pokeList = [];

  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('element').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      pokeList.add(elementModel.fromDocumentSnapshot(doc));
    }
  } catch (e) {
    print("Error getting data: $e");
  }

  return pokeList;
}


Future<int?> getTransactionID() async {
   int? transID;

  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('transaction').get();

    if (querySnapshot.docs.isEmpty) {
      transID = 0;
    }
    else {
      QueryDocumentSnapshot<Map<String, dynamic>> lastDocument = querySnapshot.docs.last;
      transID = lastDocument['id'] as int?;
    }
  } catch (e) {
    print("Error getting data: $e");
  }

  return transID;
}

Future<List<transactionModel>> getTransaction() async {
  List<transactionModel> transactionList = [];

  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('transaction').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      transactionList.add(transactionModel.fromDocumentSnapshot(doc));
    }
  } catch (e) {
    print("Error getting data: $e");
  }

  return transactionList;
}