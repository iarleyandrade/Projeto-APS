// ignore_for_file: public_member_api_docs

class Item {
  Item({
    required this.id,
    required this.name,
    required this.descricao,
    required this.local,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json["name"] as String,
      descricao: json["descricao"] as String,
      local: json["local"] as String,
      id: "",
    );
  }
  String id;
  String name;
  String descricao;
  String local;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "name": name,
      "descricao": descricao,
      "local": local,
    };
  }
}
