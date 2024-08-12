import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String?> ChangeData(String collection, String fieldName, String newValue) async {
  User? user = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection(collection).doc(user!.uid).update({
      fieldName: newValue,
    });

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection(collection).doc(user.uid).get();

    if (documentSnapshot.exists) {
      return documentSnapshot.get(fieldName).toString();
    } else {
      return null;
    }
  } catch (e) {
    print("Error updating data: $e");
    return null;
  }
}

Future<void> updatePoke(String ID, String New_Name, String New_Desc,String New_Element1, String New_Element2, double New_Price ) async {

  DocumentReference documentReference = FirebaseFirestore.instance.collection('pokemon').doc(ID);
  Map<String, dynamic> data = {
    'name': New_Name,
    'desc': New_Desc,
    'element1': New_Element1,
    'element2': New_Element2,
    'price': New_Price,
  };

  try {
    await documentReference.update(data);
    print('Data updated successfully');
  } catch (e) {
    print('Error updating data: $e');
  }
}