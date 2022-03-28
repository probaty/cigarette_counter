import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreApi {
  final CollectionReference counterCollection =
      FirebaseFirestore.instance.collection('counter');

  Stream<DocumentSnapshot> stream(String docId) {
    return counterCollection.doc(docId).snapshots();
  }

  Future<bool> checkExisting(String docId) async {
    final doc = await counterCollection.doc(docId).get();
    if (doc.exists) {
      return true;
    }
    return false;
  }

  Future<void> set(String docId, int count) {
    return counterCollection.doc(docId).set({'date': docId, 'count': count});
  }
}
