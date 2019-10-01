import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _firestoreService =
  FirestoreService._internal();
  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map(
          (snapshot) => snapshot.documents.map(
            (doc) => Product.fromMap(doc.data, doc.documentID),
      ).toList(),
    );
  }
}

class Product {
  final String name;
  final String image;
  final String id;

  Product({this.name, this.image, this.id});

  Product.fromMap(Map<String,dynamic> data, String id):
        name=data["name"],
        image=data['image'],
        id=id;
}