import 'package:flutter/material.dart';
import 'package:target_sistemas/features/login/presentation/controller/login_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import 'text_editor_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Uri _url = Uri.parse('https://www.google.com/?&hl=pt-BR');

  final controller = LoginController();

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
                        validator: controller.validateUsername,
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
                        validator: controller.validatePassword,
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
                      onTap: _launchUrl,
                      child: const Text(
                        'Política de Privacidade',
                        style: TextStyle(color: Colors.white),
                      ),
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

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void loginUser() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TextEditorPage()));
      print('login realizado com sucesso');
    }
  }
}
