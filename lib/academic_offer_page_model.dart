import 'package:flutter/material.dart';
import 'package:loyola_app22/app_components/form_field_controller.dart';

class OfertaAcademicaPageModel {
  final unfocusNode = FocusNode();

  TextEditingController? textController;
  FocusNode? textFieldFocusNode;
  String? Function(BuildContext, String?)? textControllerValidator;

  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;

  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;

  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
