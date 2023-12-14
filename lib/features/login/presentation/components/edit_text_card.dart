import 'package:flutter/material.dart';

class EditTextCard extends StatefulWidget {
  final String textTitle;
  const EditTextCard({super.key, required this.textTitle});

  @override
  State<EditTextCard> createState() => _EditTextCardState();
}

class _EditTextCardState extends State<EditTextCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              boxShadow: [BoxShadow()], color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.textTitle,
                overflow: TextOverflow.fade,
              ),
              const Icon(Icons.edit),
              GestureDetector(
                child: const Icon(Icons.cancel),
              ),
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
