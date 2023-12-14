import 'package:flutter/material.dart';

import 'text_editor_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(13, 134, 145, 100),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Center(
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        "Usuário",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: loginController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                        ),
                        validator: _validateUsername,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  const Center(
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        "Senha",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                        ),
                        validator: _validatePassword,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(158, 3, 252, 53)),
                      child: TextButton(
                        onPressed: () {
                          loginUser();
                        },
                        child: const Text(
                          'Entrar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      child: const Text(
                        'Política de Privacidade',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TextEditorPage()));
      print('login realizado com sucesso');
    }
  }

  String? _validateUsername(String? value) {
    if (value!.length > 20) {
      return 'Limite máximo de 20 Caracteres';
    }

    if (value.isEmpty) {
      return 'Campo está vazio';
    }

    if (value.endsWith(' ')) {
      return 'O login não deve terminar com caracter de espaço no final';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Campo está vazio';
    }

    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'A senha não deve conter caracteres especiais';
    }

    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'a senha deve conter apenas letras e números';
    }

    if (value.length > 20) {
      return 'Limite máximo de 20 Caracteres';
    }

    if (value.length < 2) {
      return 'Senha deve conter no mínimo 2 caracteres';
    }

    if (value.endsWith(' ')) {
      return 'A senha não deve terminar com caracter de espaço no final';
    }
    return null;
  }
}
