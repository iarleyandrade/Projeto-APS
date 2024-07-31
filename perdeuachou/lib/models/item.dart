// ignore_for_file: public_member_api_docs

class Item {
  Item({
    required this.itemName,
    required this.itemDescricao,
    required this.itemLocal,
    required this.itemId,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemName: json["itemName"] as String,
      itemDescricao: json["itemDescricao"] as String,
      itemLocal: json["itemLocal"] as String,
      itemId: json["itemId"] as String,
    );
  }
  String itemName;
  String itemDescricao;
  String itemLocal;
  String itemId;

  Map<String, dynamic> toJson() {
    return <String, String>{
      "itemName": itemName,
      "itemDescricao": itemDescricao,
      "itemLocal": itemLocal,
      "itemId": itemId,
    };
  }
}
