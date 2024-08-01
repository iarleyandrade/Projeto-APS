// ignore_for_file: public_member_api_docs, always_specify_types

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class DropDawnLocal extends StatefulWidget {
  const DropDawnLocal({super.key});

  @override
  State<DropDawnLocal> createState() => _DropDawnLocalState();
}

class _DropDawnLocalState extends State<DropDawnLocal> {
  String selectedLocal = "0";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Local").snapshots(),
      builder: (context, snapshot) {
        final List<DropdownMenuItem> clientLocais = [];
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          final clients = snapshot.data?.docs.reversed.toList();
          clientLocais.add(
            const DropdownMenuItem(
              value: "0",
              child: Text("Selecione o Local"),
            ),
          );
          for (final client in clients!) {
            clientLocais.add(
              DropdownMenuItem(
                value: client.id,
                child: Text(client["localName"] as String),
              ),
            );
          }
        }
        return DropdownButton(
          items: clientLocais,
          onChanged: (clientValue) {
            setState(() {
              selectedLocal = clientValue as String;
            });
          },
          value: selectedLocal,
        );
      },
    );
  }
}
