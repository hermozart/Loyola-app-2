import 'package:flutter/material.dart';
import 'package:loyola_app22/app_components/form_field_controller.dart';

class HorariosPageModel {
  final unfocusNode = FocusNode();

  TextEditingController? textController;
  FocusNode? textFieldFocusNode;
  String? Function(BuildContext, String?)? textControllerValidator;

  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
