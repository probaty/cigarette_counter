import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final CollectionReference counterCollection =
      FirebaseFirestore.instance.collection('counter');

  Stream<DocumentSnapshot> getItemById(String docId) {
    return counterCollection.doc(docId).snapshots();
  }

  Stream<QuerySnapshot> getAllItems() {
    return counterCollection.snapshots();
  }

  Future<bool> checkExisting(String docId) async {
    final doc = await counterCollection.doc(docId).get();
    if (doc.exists) {
      return true;
    }
    return false;
  }

  Future<void> setItemCountById(String docId, int count) {
    return counterCollection.doc(docId).set({'date': docId, 'count': count});
  }
}
