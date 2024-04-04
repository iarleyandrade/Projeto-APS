// ignore_for_file: public_member_api_docs

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_core/firebase_core.dart";
import "package:perdeuachou/models/Item.dart";

class ItemServico {
  ItemServico() {
    Firebase.initializeApp();
  }

  final CollectionReference<Map<String, dynamic>> _itemsCollection =
      FirebaseFirestore.instance.collection("MyItens");

  Future<void> addItem(Item item) async {
    await _itemsCollection.add(item.toJson());
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

  Future<void> updateItem(String itemId, Item newItem) async {
    await _itemsCollection.doc(itemId).update(newItem.toJson());
  }

  Future<void> deleteItem(String itemId) async {
    await _itemsCollection.doc(itemId).delete();
  }
}
