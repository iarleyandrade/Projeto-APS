// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import "package:perdeuachou/models/Item.dart";

class ItemAdapter {
  ItemAdapter(this.externalApi);
  dynamic externalApi;

  Item convertToItem() {
    final dynamic externalData = externalApi.fetchItem();
    return Item(
      itemName: externalData["name"] as String,
      itemDescricao: externalData["desc"] as String,
      itemLocal: externalData["location"] as String,
      itemId: externalData["id"] as String,
    );
  }
}
