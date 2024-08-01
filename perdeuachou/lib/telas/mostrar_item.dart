// ignore_for_file: public_member_api_docs, camel_case_types, always_specify_types, avoid_dynamic_calls, type_annotate_public_apis, always_declare_return_types

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:perdeuachou/servicos/item_servico.dart";

class mostrarItem extends StatefulWidget {
  const mostrarItem({super.key});

  @override
  State<mostrarItem> createState() => _mostrarItemState();
}

class _mostrarItemState extends State<mostrarItem> {
  Stream? itemStream;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController localcontroller = TextEditingController();
  TextEditingController descricaocontroller = TextEditingController();

  getOnTheLoad() async {
    itemStream = await ItemServico().getItemDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length as int,
                itemBuilder: (context, index) {
                  final DocumentSnapshot ds =
                      snapshot.data.docs[index] as DocumentSnapshot;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Name: ${ds["itemName"] as String}",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 59, 57, 57),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    namecontroller.text =
                                        ds["itemName"] as String;
                                    localcontroller.text =
                                        ds["itemLocal"] as String;
                                    descricaocontroller.text =
                                        ds["itemDescricao"] as String;
                                    editItemDetail(
                                      ds["itemId"] as String,
                                      context,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Color.fromARGB(255, 59, 57, 57),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onTap: () async {
                                    await ItemServico()
                                        .deleteItem(ds["itemId"] as String)
                                        .then((value) {
                                      Fluttertoast.showToast(
                                        msg: "Item deletado com sucesso",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                            Text(
                              "Local: ${ds["itemLocal"] as String}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 59, 57, 57),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Descrição: ${ds["itemDescricao"] as String}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 59, 57, 57),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Align(
                alignment: FractionalOffset.bottomCenter,
                child: CircularProgressIndicator(),
              );
      },
      stream: FirebaseFirestore.instance.collection("MyItens").snapshots(),
    );
  }

  Future editItemDetail(String id, BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    const Text(
                      "Editar",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Detalhes",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Nome",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: namecontroller,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Local",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: localcontroller,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Descrição",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: descricaocontroller,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final Map<String, dynamic> updateInfo = {
                        "itemName": namecontroller.text,
                        "itemId": id,
                        "itemLocal": localcontroller.text,
                        "itemDescricao": descricaocontroller.text,
                      };
                      await ItemServico()
                          .updateItem(id, updateInfo)
                          .then((value) {
                        Fluttertoast.showToast(
                          msg: "Item atualizado com sucesso",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Atualizar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
