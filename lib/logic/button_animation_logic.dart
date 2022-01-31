import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:riverpod_countup/logic/count_data_change_notifier.dart';

import '../data/count_data.dart';

class ButtonAnimationLogic with CountDataChangedNotifier {
  late AnimationController _animationController;
  late Animation<double> _animationScale;
  late Animation<double> _animationRotation;
  late AnimationCombination animationCombination;

  ValueChangedCondition startCondition;

  ButtonAnimationLogic(TickerProvider tickerProvider, this.startCondition) {
    _animationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 500),
    );

    _animationScale = _animationController //
        .drive(CurveTween(curve: const Interval(0.1, 0.7)))
        .drive(Tween(begin: 1.0, end: 1.8));

    _animationRotation = _animationController //
        .drive(
          CurveTween(
            curve: Interval(
              0.4,
              0.9,
              curve: ButtonRotateCurve(),
            ),
          ),
        )
        .drive(Tween(begin: 0.0, end: 1.0));

    animationCombination = AnimationCombination(animationScale: _animationScale, animationRotation: _animationRotation);
  }

  void dispose() {
    _animationController.dispose();
  }

  void start() {
    _animationController //
        .forward()
        .whenComplete(() => _animationController.reset()); // 元に戻す
  }

  @override
  void valueChanged(CountData oldData, CountData newData) {
    if (startCondition(oldData, newData)) {
      start();
    }
  }
}

class ButtonRotateCurve extends Curve {
  @override
  double transform(double t) {
    return math.sin(2 * math.pi * t) / 16;
  }
}

class AnimationCombination {
  final Animation<double> animationScale;
  final Animation<double> animationRotation;

  AnimationCombination({
    required this.animationScale,
    required this.animationRotation,
  });
}
