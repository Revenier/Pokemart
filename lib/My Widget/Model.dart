import 'package:cloud_firestore/cloud_firestore.dart';

class accountModel{
  String name;
  String email;
  String pw;
  String role;

  accountModel({
    required this.name,
    required this.email,
    required this. pw,
    required this.role
});

  factory accountModel.fromDocumentSnapshot(DocumentSnapshot doc){
    return accountModel(
        name: doc['name'],
        email: doc['email'],
        pw: doc['pw'],
        role: doc['role']
    );
  }
}

class PokeModel{
  String id;
  String name;
  String element1;
  String element2;
  String image_link;
  String desc;
  double price;

  PokeModel({
    required this.id,
    required this.name,
    required this.element1,
    required this.element2,
    required this.image_link,
    required this.desc,
    required this.price
  });

  factory PokeModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return PokeModel(
      id: doc.id,
      name: doc['name'],
      element1: doc['element1'],
      element2: doc['element2'],
      image_link: doc['image'],
      desc: doc['desc'],
      price: doc['price'],
    );
  }
}

class elementModel{
  String name;
  String image_link;
  String color;

  elementModel({
    required this.name,
    required this.image_link,
    required this.color
  });

  factory elementModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return elementModel(
      name: doc['name'],
      image_link: doc['image'],
      color: doc['color']
    );
  }
}

class transactionModel{
  String TransactionID;
  String userName;
  String userEmail;
  String PokeName;
  String PokeID;
  String PokeImage;
  double price;

  transactionModel({
    required this.TransactionID,
    required this.userName,
    required this.userEmail,
    required this.PokeName,
    required this.PokeID,
    required this.PokeImage,
    required this.price,
});

  factory transactionModel.fromDocumentSnapshot(DocumentSnapshot doc){
    return transactionModel(
        TransactionID: doc.id,
        userName: doc['User Name'],
        userEmail: doc['User Email'],
        PokeName: doc['Pokemon Name'],
        PokeID: doc['PokeID'],
        PokeImage: doc['image'],
        price : doc['price'],
    );
  }
}

