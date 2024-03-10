import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perdeuachou/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _verSenha = false;
  bool _entrar = true;

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
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                    hintText: 'nome@email.com',
                  ),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Digite seu E-mail';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !_verSenha,
                  controller: _senhaController,
                  decoration: InputDecoration(
                      label: const Text('Senha'),
                      hintText: 'Digite sua senha',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _verSenha = !_verSenha;
                            });
                          },
                          icon: Icon(_verSenha
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined))),
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Digite sua senha';
                    } else if (senha.length < 6) {
                      return 'Digite uma senha mais forte';
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
                    children: [
                      TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !_verSenha,
                          controller: _senhaController,
                          decoration: const InputDecoration(
                            label: Text('Senha'),
                            hintText: 'Digite novamente sua senha',
                          ),
                          validator: (senha) {
                            if (senha == null || senha.isEmpty) {
                              return 'Digite sua senha';
                            } else if (senha.length < 6) {
                              return 'Digite uma senha mais forte';
                            }
                            return null;
                          }),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                          hintText: 'Nome',
                        ),
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Digite seu Nome';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        logar();
                      }
                    },
                    child: Text((_entrar) ? 'Entrar' : 'Cadastrar')),
                const Divider(),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _entrar = !_entrar;
                      });
                    },
                    child: Text((_entrar)
                        ? "Ainda não tem uma conta? Cadastre-se!"
                        : 'Já tem uma conta? Entre!')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  logar() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
    var url = Uri.parse('servidor');
    var response = await http.post(url, body: {
      'login': _emailController.text,
      'password': _senhaController.text,
    });

    if (response.statusCode == 200) {
      String token = json.decode(response.body)['token'];
      await sharedPreferences.setString('token', 'Token $token');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
          content: Text(
            'E-mail ou Senha inválidos',
          )));
    }
  }
}
