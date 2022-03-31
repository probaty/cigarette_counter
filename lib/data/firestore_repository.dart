import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  final CollectionReference counterCollection =
      FirebaseFirestore.instance.collection('counter');

  Stream<DocumentSnapshot> getItemById(String docId) {
    return counterCollection.doc(docId).snapshots();
  }

  Stream<QuerySnapshot> getAllItemsOrderBy({String? orderBy}) {
    if (orderBy != null) {
      return counterCollection.orderBy(orderBy, descending: true).snapshots();
    }
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
    return counterCollection.doc(docId).update({'count': count});
  }

  Future<void> setInitItem(String docId, int count, DateTime dateTime) {
    return counterCollection
        .doc(docId)
        .set({'date': docId, 'count': count, 'dateTime': dateTime});
  }
}
