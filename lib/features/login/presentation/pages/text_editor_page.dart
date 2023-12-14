import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_sistemas/features/login/presentation/components/edit_text_card.dart';

class TextEditorPage extends StatefulWidget {
  const TextEditorPage({super.key});

  @override
  State<TextEditorPage> createState() => _TextEditorPageState();
}

class _TextEditorPageState extends State<TextEditorPage> {
  final TextEditingController textEditController = TextEditingController();

  late final SharedPreferences prefs;

  getPreferences() async {
    final prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getPreferences();
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
                  itemBuilder: (_, index) =>
                      EditTextCard(textTitle: textInputted[index]),
                  itemCount: textInputted.length,
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
                  onSubmitted: (value) {
                    setState(() {
                      textInputted.add(value);
                      prefs.setStringList('inputedList', textInputted);
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

  final List<String> textInputted = [];
}
