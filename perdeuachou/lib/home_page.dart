// ignore_for_file: public_member_api_docs, avoid_print

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:perdeuachou/models/Item.dart";
import "package:perdeuachou/servicos/autenticacao_servico.dart";
import "package:perdeuachou/servicos/item_servico.dart";

// ignore: duplicate_ignore
// ignore: public_member_api_docs
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? itemName;
  String? itemDescricao;
  String? itemLocal;

  dynamic setItemName(String name) => itemName = name;

  dynamic setItemDescricao(String descricao) => itemDescricao = descricao;

  dynamic setItemLocal(String local) => itemLocal = local;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perdeu ou Achou?"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Deslogar"),
              onTap: () {
                AutenticacaoServico().deslogarUsuario();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Item",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String itemName) {
                  setItemName(itemName);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Descrição",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String descricao) {
                  setItemDescricao(descricao);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Onde foi deixado",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String local) {
                  setItemLocal(local);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Cadastrar"),
                  onPressed: () {
                    ItemServico().addItem(
                      Item(
                        name: itemName!,
                        descricao: itemDescricao!,
                        local: itemLocal!,
                        id: itemName!,
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Ler"),
                  onPressed: () {
                    ItemServico().getItems();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Atualizar"),
                  onPressed: () {
                    ItemServico().updateItem(
                      itemName!,
                      Item(
                        name: itemName!,
                        descricao: itemDescricao!,
                        local: itemLocal!,
                        id: itemName!,
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Apagar"),
                  onPressed: () {
                    ItemServico().deleteItem(itemName!);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Expanded(child: Text("Name")),
                Expanded(child: Text("Descricao")),
                Expanded(child: Text("Onde foi perdido")),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            // ignore: always_specify_types
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("MyItens").snapshots(),
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
              ) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot<Object?> documentSnapshot =
                          snapshot.data!.docs[index]
                              as DocumentSnapshot<Object?>;
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(documentSnapshot["name"] as String),
                          ),
                          Expanded(
                            child: Text(
                              documentSnapshot["descricao"] as String,
                            ),
                          ),
                          Expanded(
                            child: Text(documentSnapshot["local"] as String),
                          ),
                        ],
                      );
                    },
                  );
                }
                return const Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
