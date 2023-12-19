import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/injection_container.dart';
import '../components/edit_text_card.dart';
import '../controller/login_controller.dart';

class TextEditorPage extends StatefulWidget {
  const TextEditorPage({super.key});

  @override
  State<TextEditorPage> createState() => _TextEditorPageState();
}

class _TextEditorPageState extends State<TextEditorPage> {
  final loginController = LoginController();
  List<String>? removedList = [];

  final TextEditingController textEditController = TextEditingController();

  final prefs = serviceLocator<SharedPreferences>();

  late FocusNode myFocusNode;

  String currentEditTextIndex = '';

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();

    if (prefs.getStringList('cachedList') != null) {
      loginController.cachedList = prefs.getStringList('cachedList');
    } else {
      loginController.cachedList = [];
    }
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
  }

  void deleteTextInputed(int index) {
    loginController.cachedList!.removeAt(index);
    removedList = loginController.cachedList;

    prefs.setStringList('cachedList', removedList!);
  }

  void editTextInput(int index, String newText) {
    loginController.cachedList![index] = newText;
    removedList = loginController.cachedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(13, 134, 145, 100),
      body: Container(
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
                child: ListView.builder(
                  itemBuilder: (_, index) => EditTextCard(
                      onEdit: () {
                        currentEditTextIndex = index.toString();
                        myFocusNode.requestFocus();
                      },
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirmar Exclusão'),
                              content: const Text(
                                  'Deseja Realmente Excluir o Texto?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      deleteTextInputed(index);
                                    });

                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text('Excluir'),
                                ),
                              ],
                            );
                          },
                        );

                        print(loginController.cachedList);
                      },
                      textTitle: loginController.cachedList!.isNotEmpty
                          ? loginController.cachedList![index]
                          : loginController.textInputted[index]),
                  itemCount: loginController.cachedList!.isNotEmpty
                      ? loginController.cachedList!.length
                      : loginController.textInputted.length,
                  shrinkWrap: true,
                ),
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
                    setState(() {
                      currentEditTextIndex.isEmpty
                          ? loginController.cachedList!.add(value)
                          : editTextInput(
                              int.parse(currentEditTextIndex), value);

                      prefs.setStringList(
                          'cachedList', loginController.cachedList!);
                    });
                    textEditController.clear();
                  },
                  controller: textEditController,
                  decoration: const InputDecoration(
                    label: Text(
                      'Digite seu Texto',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                deleteTextInputed(index);
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
