import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:target_sistemas/features/login/presentation/controller/login_controller.dart';

class EditTextCard extends StatefulWidget {
  final String textTitle;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  const EditTextCard(
      {super.key, required this.textTitle, this.onTap, this.onEdit});

  @override
  State<EditTextCard> createState() => _EditTextCardState();
}

class _EditTextCardState extends State<EditTextCard> {
  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.white,
            )
          ], color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.textTitle,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                  onTap: widget.onEdit,
                  child: const Icon(
                    Icons.edit,
                    size: 30,
                  )),
              GestureDetector(
                  onTap: widget.onTap,
                  child: const Icon(
                    Icons.cancel,
                    size: 30,
                    color: Color.fromARGB(255, 174, 15, 4),
                  )),
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
