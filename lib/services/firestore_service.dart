import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference attractions =
      FirebaseFirestore.instance.collection('attractions');

  Future<void> addAttraction({
    required String name,
    required String category,
    required String description,
  }) async {
    await attractions.add({
      'name': name,
      'category': category,
      'description': description,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getAttractions() {
    return attractions.orderBy('createdAt').snapshots();
  }

  Future<void> deleteAttraction(String id) async {
    await attractions.doc(id).delete();
  }

  Future<void> updateAttraction(
    String id,
    String name,
    String category,
    String description,
  ) async {
    await attractions.doc(id).update({
      'name': name,
      'category': category,
      'description': description,
    });
  }
}