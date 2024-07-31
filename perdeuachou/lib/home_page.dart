// ignore_for_file: public_member_api_docs, avoid_print, always_specify_types

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:perdeuachou/servicos/autenticacao_servico.dart";
import "package:perdeuachou/telas/cadastro_item.dart";
import "package:perdeuachou/telas/mostrar_item.dart";

// ignore: duplicate_ignore
// ignore: public_member_api_docs
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 225, 225),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const cadastroItem(),
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
              "Perdeu?",
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
      body: Container(
        margin: const EdgeInsets.only(right: 20, left: 20, top: 30),
        child: const Column(
          children: [
            Expanded(child: mostrarItem()),
          ],
        ),
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
    );
  }
}
