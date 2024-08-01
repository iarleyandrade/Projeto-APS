// ignore_for_file: public_member_api_docs

class Local {
  Local({
    required this.localName,
    required this.localDescricao,
    required this.localId,
  });

  factory Local.fromJson(Map<String, dynamic> json) {
    return Local(
      localName: json["localName"] as String,
      localDescricao: json["localDescricao"] as String,
      localId: json["localId"] as String,
    );
  }
  String localName;
  String localDescricao;
  String localId;

  Map<String, dynamic> toJson() {
    return <String, String>{
      "localName": localName,
      "localDescricao": localDescricao,
      "localId": localId,
    };
  }
}
