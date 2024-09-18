// ignore_for_file: public_member_api_docs

class Singleton {
  factory Singleton() {
    return _instance;
  }

  Singleton._internal();
  static final Singleton _instance = Singleton._internal();

  String data = "Valor inicial";
}
