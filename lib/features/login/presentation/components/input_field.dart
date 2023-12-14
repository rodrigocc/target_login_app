import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController? inputController;
  final Widget? icon;
  const InputField({super.key, this.inputController, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
        ),
        child: TextField(
          controller: inputController,
          decoration: InputDecoration(
            icon: icon,
          ),
        ),
      ),
    );
  }
}
