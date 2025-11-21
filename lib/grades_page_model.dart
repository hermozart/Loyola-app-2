import 'package:flutter/material.dart';
import 'package:loyola_app22/app_components/form_field_controller.dart';

class GradesPageModel {
  final unfocusNode = FocusNode();

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }
}
