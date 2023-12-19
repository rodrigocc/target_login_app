import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  List<String>? cachedList = [];
  List<String>? listCachedInputed = [];

  final List<String> textInputted = [];

  @action
  void deleteTextInputed(int index) {
    cachedList!.removeAt(index);
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
