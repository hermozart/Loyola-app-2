import 'package:flutter/material.dart';

class NewsPageModel {
  final unfocusNode = FocusNode();

  TextEditingController? textController;
  FocusNode? textFieldFocusNode;
  String? Function(BuildContext, String?)? textControllerValidator;

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
