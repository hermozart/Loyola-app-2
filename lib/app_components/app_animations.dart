import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum AnimationTrigger {
  onPageLoad,
  onActionTrigger,
}

class AnimationInfo {
  AnimationInfo({
    required this.trigger,
    required this.effectsBuilder,
    this.loop = false,
    this.reverse = false,
    this.applyInitialState = false,
  });

  final AnimationTrigger trigger;
  final List<Effect<dynamic>> Function() effectsBuilder;
  final bool applyInitialState;
  final bool loop;
  final bool reverse;
}

void setupAnimations(Iterable<AnimationInfo> animations, TickerProvider vsync) {
  // Setup animations if needed
}

extension AnimateOnPageLoad on Widget {
  Widget animateOnPageLoad(AnimationInfo? animationInfo) {
    if (animationInfo == null) return this;
    return Animate(
      effects: animationInfo.effectsBuilder(),
      child: this,
    );
  }
}

extension AnimateOnActionTrigger on Widget {
  Widget animateOnActionTrigger(AnimationInfo animationInfo) {
    return Animate(
      effects: animationInfo.effectsBuilder(),
      child: this,
    );
  }
}

// Effects
Effect<dynamic> TiltEffect({
  Duration? delay,
  Duration? duration,
  Curve? curve,
  double? begin,
  double? end,
}) {
  return RotateEffect(
    delay: delay,
    duration: duration,
    curve: curve,
    begin: begin,
    end: end,
  );
}
