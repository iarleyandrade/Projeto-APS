// ignore_for_file: unnecessary_parenthesis, public_member_api_docs

import "package:flutter/material.dart";
import "package:perdeuachou/core/my_snackbar.dart";
import "package:perdeuachou/servicos/autenticacao_servico.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  bool _verSenha = false;
  bool _entrar = true;

  final AutenticacaoServico _authServico = AutenticacaoServico();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text("E-mail"),
                    hintText: "nome@email.com",
                  ),
                  validator: (String? email) {
                    if (email == null || email.isEmpty) {
                      return "Digite seu e-mail";
                    }
                    if (!email.contains("@")) {
                      return "Email invalido";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_verSenha,
                  controller: _senhaController,
                  decoration: InputDecoration(
                    label: const Text("Senha"),
                    hintText: "Digite sua senha",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _verSenha = !_verSenha;
                        });
                      },
                      icon: Icon(
                        _verSenha
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (String? senha) {
                    if (senha == null || senha.isEmpty) {
                      return "Digite sua senha";
                    } else if (senha.length < 6) {
                      return "Digite uma senha mais forte";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Visibility(
                  visible: !_entrar,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _nomeController,
                        decoration: const InputDecoration(
                          label: Text("Nome"),
                          hintText: "Nome",
                        ),
                        validator: (String? email) {
                          if (email == null || email.isEmpty) {
                            return "Digite seu Nome";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    botaoPrincipalClicado();
                  },
                  child: Text((_entrar) ? "Entrar" : "Cadastrar"),
                ),
                const Divider(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _entrar = !_entrar;
                    });
                  },
                  child: Text(
                    _entrar
                        ? "Ainda não tem uma conta? Cadastre-se!"
                        : "Já tem uma conta? Entre!",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dynamic botaoPrincipalClicado() {
    final String email = _emailController.text;
    final String senha = _senhaController.text;
    final String nome = _nomeController.text;

    if (_formKey.currentState!.validate()) {
      if (_entrar) {
        _authServico.logarUsuario(email: email, senha: senha).then(
          (String? erro) {
            if (erro != null) {
              showSnackBar(context: context, text: erro);
            }
          },
        );
      } else {
        _authServico
            .cadastrarUsuario(nome: nome, senha: senha, email: email)
            .then(
          (String? erro) {
            if (erro != null) {
              showSnackBar(context: context, text: erro);
            }
          },
        );
      }
    }
  }
}
