import 'package:flutter/material.dart';
import 'package:loyola_app22/app_components/form_field_controller.dart';

const kTransitionInfoKey = 'transition_info';

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;
}

enum PageTransitionType {
  fade,
  slideUp,
  slideDown,
  slideLeft,
  slideRight,
  scale,
  rotate,
  leftToRight,
  rightToLeft,
}

void safeSetState(void Function() fn) {
  fn();
}

T createModel<T>(BuildContext context, T Function() create) {
  return create();
}

extension ListDivideExt on List<Widget> {
  List<Widget> divide(Widget divider) {
    if (isEmpty) return this;
    final result = <Widget>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(divider);
      }
    }
    return result;
  }

  List<Widget> addToStart(Widget widget) {
    return [widget, ...this];
  }

  List<Widget> addToEnd(Widget widget) {
    return [...this, widget];
  }
}

extension ValidatorExtension on String? Function(BuildContext, String?)? {
  String? Function(String?)? asValidator(BuildContext context) {
    if (this == null) return null;
    return (String? value) => this!(context, value);
  }
}

extension BuildContextExtensions on BuildContext {
  void pop() => Navigator.of(this).pop();

  Future<T?> pushNamed<T>(String routeName, {Object? extra}) {
    final extraMap = extra as Map<String, dynamic>?;
    return Navigator.of(this).pushNamed<T>(routeName, arguments: extraMap);
  }
}
