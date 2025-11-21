import 'package:flutter/material.dart';
import 'package:loyola_app22/app_components/form_field_controller.dart';

class LoginPageModel {
  final unfocusNode = FocusNode();

  TextEditingController? tfCodigoTextController;
  FocusNode? tfCodigoFocusNode;
  String? Function(BuildContext, String?)? tfCodigoTextControllerValidator;

  TextEditingController? tfCITextController;
  FocusNode? tfCIFocusNode;
  String? Function(BuildContext, String?)? tfCITextControllerValidator;

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    tfCodigoFocusNode?.dispose();
    tfCodigoTextController?.dispose();
    tfCIFocusNode?.dispose();
    tfCITextController?.dispose();
  }
}
