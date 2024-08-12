import 'package:cloud_firestore/cloud_firestore.dart';

void deletePoke(String Id) async {
  // Replace 'your_collection' with the name of your collection
  // Replace 'your_document_id' with the ID of the document you want to delete
  DocumentReference documentReference = FirebaseFirestore.instance.collection('pokemon').doc(Id);

  try {
    await documentReference.delete();
    print('Document deleted successfully');
  } catch (e) {
    print('Error deleting document: $e');
  }
}
