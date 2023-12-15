import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/injection_container.dart';
import '../components/edit_text_card.dart';

class TextEditorPage extends StatefulWidget {
  const TextEditorPage({super.key});

  @override
  State<TextEditorPage> createState() => _TextEditorPageState();
}

class _TextEditorPageState extends State<TextEditorPage> {
  final TextEditingController textEditController = TextEditingController();

  List<String>? cachedList = [];
  List<String>? listCachedInputed = [];

  final List<String> textInputted = [];

  final prefs = serviceLocator<SharedPreferences>();

  @override
  void initState() {
    super.initState();

    cachedList = prefs.getStringList('inputedList');
    listCachedInputed = prefs.getStringList('cachedList');
    cachedList!.addAll(listCachedInputed!.map((e) => e));

    print(cachedList);
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
                      textTitle: cachedList!.isNotEmpty
                          ? cachedList![index]
                          : textInputted[index]),
                  itemCount: cachedList!.isNotEmpty
                      ? cachedList!.length
                      : textInputted.length,
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
                      cachedList!.isEmpty
                          ? textInputted.add(value)
                          : cachedList!.add(value);

                      cachedList!.isEmpty
                          ? prefs.setStringList('inputedList', textInputted)
                          : prefs.setStringList('cachedList', cachedList!);
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
