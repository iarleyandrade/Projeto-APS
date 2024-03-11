import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:perdeuachou/servicos/autenticacao_servico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? itemName, itemDescricao, itemLocal;

  setItemName(name) {
    itemName = name;
  }

  setItemDescricao(descricao) {
    itemDescricao = descricao;
  }

  setItemLocal(local) {
    itemLocal = local;
  }

  createItem() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyItens").doc(itemName);

    Map<String, dynamic> itens = {
      "itemName": itemName,
      "itemDescricao": itemDescricao,
      "itemLocal": itemLocal
    } as Map<String, dynamic>;

    documentReference.set(itens).whenComplete(() {});
  }

  updateItem() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyItens").doc(itemName);

    Map<String, dynamic> itens = {
      "itemName": itemName,
      "itemDescricao": itemDescricao,
      "itemLocal": itemLocal
    } as Map<String, dynamic>;

    documentReference.set(itens).whenComplete(() {});
  }

  readItem() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyItens").doc(itemName);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data());
    });
  }

  deleteItem() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyItens").doc(itemName);

    documentReference.delete().whenComplete(() => print('$itemName deletado'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perdeu ou Achou?'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Deslogar"),
              onTap: () {
                AutenticacaoServico().deslogarUsuario();
              },
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: const Text("Cadastrar"),
                  onPressed: () {
                    createItem();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: const Text("Ler"),
                  onPressed: () {
                    readItem();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: const Text("Atualizar"),
                  onPressed: () {
                    updateItem();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: const Text("Apagar"),
                  onPressed: () {
                    deleteItem();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              textDirection: TextDirection.ltr,
              children: [
                Expanded(child: Text("Name")),
                Expanded(child: Text("Descricao")),
                Expanded(child: Text("Onde foi perdido")),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("MyItens")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot = snapshot
                              .data?.docs[index] as DocumentSnapshot<Object?>;
                          return Row(
                            children: [
                              Expanded(
                                child: Text(documentSnapshot["itemName"]),
                              ),
                              Expanded(
                                child: Text(documentSnapshot["itemDescricao"]),
                              ),
                              Expanded(
                                child: Text(documentSnapshot["itemLocal"]),
                              ),
                            ],
                          );
                        });
                  }
                  return const Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CircularProgressIndicator(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
