import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_sistemas/features/login/presentation/controller/login_controller.dart';
import '../../../../config/injection_container.dart';
import '../components/edit_text_card.dart';

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

    loginController.cachedList = prefs.getStringList('cachedList');
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
  }

  void deleteTextInputed(int index) {
    loginController.cachedList!.removeAt(index);
    removedList = loginController.cachedList!;

    prefs.setStringList('cachedList', removedList!);
  }

  void editTextInput(int index, String newText) {
    loginController.cachedList![index] = newText;
    removedList = loginController.cachedList!;
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
                        setState(() {
                          deleteTextInputed(index);
                        });

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
}
