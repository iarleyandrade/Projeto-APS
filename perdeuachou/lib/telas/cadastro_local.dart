// ignore_for_file: public_member_api_docs, camel_case_types, always_specify_types

import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:perdeuachou/models/local.dart";
import "package:perdeuachou/servicos/local_servico.dart";
import "package:random_string/random_string.dart";

class cadastroLocal extends StatefulWidget {
  const cadastroLocal({super.key});

  @override
  State<cadastroLocal> createState() => _cadastroLocalState();
}

class _cadastroLocalState extends State<cadastroLocal> {
  String? localName;
  String? localDescricao;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController descricaocontroller = TextEditingController();

  dynamic setLocalName(String name) => localName = name;

  dynamic setLocalDescricao(String descricao) => localDescricao = descricao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Local?",
              style: TextStyle(
                color: Colors.red,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Cadastre!",
              style: TextStyle(
                color: Colors.green,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 24.0, top: 30.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                  final String id = randomAlphaNumeric(10);

                  await LocalServico()
                      .addLocalDetails(
                    Local(
                      localName: namecontroller.text,
                      localDescricao: descricaocontroller.text,
                      localId: id,
                    ),
                    id,
                  )
                      .then(
                    (value) {
                      Fluttertoast.showToast(
                        msg: "Local cadastrado com sucesso!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      Navigator.pop(context);
                    },
                  );
                },
                child: const Text(
                  "Cadastrar",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
