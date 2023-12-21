import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../components/edit_text_card.dart';
import '../controller/login_controller.dart';

class TextEditorPage extends StatefulWidget {
  const TextEditorPage({super.key});

  @override
  State<TextEditorPage> createState() => _TextEditorPageState();
}

class _TextEditorPageState extends State<TextEditorPage> {
  final loginController = LoginController();

  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    loginController.getCachedList();
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(156, 24, 72, 76),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(156, 27, 85, 95),
          Color.fromRGBO(16, 189, 204, 0.612),
        ])),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow()],
                ),
                child: Observer(builder: (context) {
                  return ListView.builder(
                    itemBuilder: (_, index) => Observer(builder: (
                      context,
                    ) {
                      return EditTextCard(
                          onEdit: () {
                            loginController.currentEditTextIndex =
                                index.toString();
                            myFocusNode.requestFocus();
                          },
                          onTap: () {
                            _showAlertDialog(context, index);
                          },
                          textTitle: loginController.cachedList!.isNotEmpty
                              ? loginController.cachedList![index]
                              : loginController.textInputted[index]);
                    }),
                    itemCount: loginController.cachedList!.isNotEmpty
                        ? loginController.cachedList!.length
                        : loginController.textInputted.length,
                    shrinkWrap: true,
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [BoxShadow()]),
                padding: const EdgeInsets.all(16),
                child: TextField(
                  focusNode: myFocusNode,
                  onSubmitted: (value) {
                    loginController.onSubmitted(value);
                    loginController.textEditController.clear();
                  },
                  controller: loginController.textEditController,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    border: InputBorder.none,
                    label: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Digite seu Texto',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Deseja Realmente Excluir o Texto?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                loginController.deleteTextInputed(index);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
