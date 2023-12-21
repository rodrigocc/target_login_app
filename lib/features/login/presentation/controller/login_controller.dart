import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../config/preference_instance.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  String currentEditTextIndex = '';

  @observable
  ObservableList<String>? cachedList = ObservableList<String>();

  @observable
  final List<String> textInputted = [];
  @observable
  List<String>? removedList = <String>[];

  final TextEditingController textEditController = TextEditingController();

  void getCachedList() {
    if (prefs.getStringList('cachedList') != null) {
      cachedList =
          ObservableList.of(prefs.getStringList('cachedList')!.toList());
    } else {
      cachedList = ObservableList<String>();
    }
  }

  @action
  void onSubmitted(String value) {
    currentEditTextIndex.isEmpty && textEditController.text.isNotEmpty
        ? cachedList!.add(value)
        : editTextInput(int.parse(currentEditTextIndex), value);

    prefs.setStringList('cachedList', cachedList!);
  }

  @action
  void editTextInput(int index, String newText) {
    cachedList![index] = newText;
    removedList = cachedList;
    currentEditTextIndex = '';
  }

  @action
  void deleteTextInputed(int index) {
    cachedList!.removeAt(index);

    removedList = cachedList;

    prefs.setStringList('cachedList', removedList!);
  }

  String? validateUsername(String? value) {
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

  String? validatePassword(String? value) {
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
