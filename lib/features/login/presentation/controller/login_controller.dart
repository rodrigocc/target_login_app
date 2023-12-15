import 'package:flutter/material.dart';
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
}
