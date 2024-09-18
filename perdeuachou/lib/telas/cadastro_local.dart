// ignore_for_file: public_member_api_docs, camel_case_types, always_specify_types, avoid_print

import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:perdeuachou/models/local.dart";
import "package:perdeuachou/servicos/local_servico.dart";
import "package:random_string/random_string.dart";
import "package:speech_to_text/speech_to_text.dart" as stt;

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

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _speechText = '';
  double _confidence = 1.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech = stt.SpeechToText();
  }

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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      try {
                        final String recognizedText = await _listen();
                        namecontroller.text = recognizedText;
                      } catch (error) {
                        print("Error listening: $error");
                      }
                    },
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  ),
                ),
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      try {
                        final String recognizedText = await _listen();
                        descricaocontroller.text = recognizedText;
                      } catch (error) {
                        print("Error listening: $error");
                      }
                    },
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  ),
                ),
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

  Future<String> _listen() async {
    if (!_isListening) {
      final bool available = await _speech.initialize(
        onStatus: (val) => print("onStatus: $val"),
        onError: (val) => print("onError: $val"),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _speechText = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }

    return _speechText;
  }
}
