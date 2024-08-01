// ignore_for_file: public_member_api_docs, always_specify_types, avoid_dynamic_calls, type_annotate_public_apis, always_declare_return_types

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";

import "package:perdeuachou/servicos/local_servico.dart";
import "package:perdeuachou/telas/cadastro_local.dart";

class MostrarLocal extends StatefulWidget {
  const MostrarLocal({super.key});

  @override
  State<MostrarLocal> createState() => _MostrarLocalState();
}

class _MostrarLocalState extends State<MostrarLocal> {
  Stream? localStream;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController descricaocontroller = TextEditingController();

  getOnTheLoad() async {
    localStream = await LocalServico().getLocalDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 225, 225),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const cadastroLocal(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Localizou?",
              style: TextStyle(
                color: Colors.red,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Achou!",
              style: TextStyle(
                color: Colors.green,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.docs.length as int,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot ds =
                              snapshot.data.docs[index] as DocumentSnapshot;

                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 20.0,
                              left: 15.0,
                              right: 15.0,
                            ),
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
                                          "Nome: ${ds["localName"] as String}",
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 59, 57, 57),
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            namecontroller.text =
                                                ds["localName"] as String;

                                            descricaocontroller.text =
                                                ds["localDescricao"] as String;

                                            editLocalDetail(
                                              ds["localId"] as String,
                                              context,
                                            );
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color:
                                                Color.fromARGB(255, 59, 57, 57),
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
                                            await LocalServico()
                                                .deleteLocal(
                                              ds["localId"] as String,
                                            )
                                                .then((value) {
                                              Fluttertoast.showToast(
                                                msg:
                                                    "local deletado com sucesso",
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
                                      "Descrição: ${ds["localDescricao"] as String}",
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
              stream:
                  FirebaseFirestore.instance.collection("Local").snapshots(),
            ),
          ),
        ],
      ),
    );
  }

  Future editLocalDetail(String id, BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
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
                      "localName": namecontroller.text,
                      "localId": id,
                      "localDescricao": descricaocontroller.text,
                    };
                    await LocalServico()
                        .updateLocal(id, updateInfo)
                        .then((value) {
                      Fluttertoast.showToast(
                        msg: "Local atualizado com sucesso",
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
      );
}
