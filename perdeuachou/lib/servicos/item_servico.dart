// ignore_for_file: public_member_api_docs, always_specify_types

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_core/firebase_core.dart";
import "package:perdeuachou/models/Item.dart";

class ItemServico {
  ItemServico() {
    Firebase.initializeApp();
  }

  final CollectionReference<Map<String, dynamic>> _itemsCollection =
      FirebaseFirestore.instance.collection("MyItens");

  Future<Stream<QuerySnapshot>> getItemDetails() async {
    return FirebaseFirestore.instance.collection("MyItens").snapshots();
  }

  Future addItemDetails(Item item, String id) async {
    return FirebaseFirestore.instance
        .collection("MyItens")
        .doc(id)
        .set(item.toJson());
  }

  Future<List<Item>> getItems() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _itemsCollection.get();
    return snapshot.docs
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              Item.fromJson(doc.data()),
        )
        .toList();
  }

  Future<void> updateItem(String id, Map<String, dynamic> uptadeInfo) async {
    return await FirebaseFirestore.instance
        .collection("MyItens")
        .doc(id)
        .update(uptadeInfo);
  }

  Future<void> deleteItem(String itemId) async {
    await _itemsCollection.doc(itemId).delete();
  }
}
