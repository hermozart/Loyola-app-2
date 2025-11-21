import 'package:flutter/material.dart';

class FormFieldController<T> extends ValueNotifier<T?> {
  FormFieldController(T? value) : super(value);
}
