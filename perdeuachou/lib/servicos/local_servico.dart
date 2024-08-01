// ignore_for_file: public_member_api_docs, always_specify_types

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_core/firebase_core.dart";

import "package:perdeuachou/models/local.dart";

class LocalServico {
  LocalServico() {
    Firebase.initializeApp();
  }

  final CollectionReference<Map<String, dynamic>> _localCollection =
      FirebaseFirestore.instance.collection("Local");

  Future<Stream<QuerySnapshot>> getLocalDetails() async {
    return FirebaseFirestore.instance.collection("Local").snapshots();
  }

  Future addLocalDetails(Local local, String id) async {
    return FirebaseFirestore.instance
        .collection("Local")
        .doc(id)
        .set(local.toJson());
  }

  Future<List<Local>> getLocais() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _localCollection.get();
    return snapshot.docs
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              Local.fromJson(doc.data()),
        )
        .toList();
  }

  Future<void> updateLocal(String id, Map<String, dynamic> uptadeInfo) async {
    return await FirebaseFirestore.instance
        .collection("Local")
        .doc(id)
        .update(uptadeInfo);
  }

  Future<void> deleteLocal(String localId) async {
    await _localCollection.doc(localId).delete();
  }

  Future getLocal(String id) async {
    return FirebaseFirestore.instance.collection("Local").doc(id).get();
  }
}
