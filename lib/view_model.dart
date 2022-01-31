import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_countup/logic/button_animation_logic.dart';
import 'package:riverpod_countup/logic/count_data_change_notifier.dart';
import 'package:riverpod_countup/logic/logic.dart';
import 'package:riverpod_countup/logic/sound_logic.dart';
import 'package:riverpod_countup/provider.dart';

import 'data/count_data.dart';

class ViewModel {
  final Logic _logic = Logic();
  final SoundLogic _soundLogic = SoundLogic();
  late ButtonAnimationLogic _buttonAnimationLogicPlus;
  late ButtonAnimationLogic _buttonAnimationLogicMinus;
  late ButtonAnimationLogic _buttonAnimationLogicReset;

  late WidgetRef _ref;

  List<CountDataChangedNotifier> notifiers = [];

  void setRef(WidgetRef ref, TickerProvider tickerProvider) {
    _ref = ref;
    // 音楽のロジック
    _soundLogic.load();
    // アニメーションのロジック
    _buttonAnimationLogicPlus = ButtonAnimationLogic(
      tickerProvider,
      (oldData, newData) => oldData.countUp + 1 == newData.countUp,
    );
    _buttonAnimationLogicMinus = ButtonAnimationLogic(
      tickerProvider,
      (oldData, newData) => oldData.countDown + 1 == newData.countDown,
    );
    _buttonAnimationLogicReset = ButtonAnimationLogic(
      tickerProvider,
      (oldData, newData) => newData.countUp == 0 && newData.countDown == 0 && newData.count == 0,
    );

    notifiers = [
      _soundLogic,
      _buttonAnimationLogicPlus,
      _buttonAnimationLogicMinus,
      _buttonAnimationLogicReset,
    ];
  }

  get count => _ref.watch(countDataProvider.select((value) => value.count)).toString();
  get countUp => _ref.watch(countDataProvider.select((value) => value.countUp)).toString();
  get countDown => _ref.watch(countDataProvider.select((value) => value.countDown)).toString();

  get animationPlus => _buttonAnimationLogicPlus.animationCombination;
  get animationMinus => _buttonAnimationLogicMinus.animationCombination;
  get animationReset => _buttonAnimationLogicReset.animationCombination;

  void onIncrease() {
    _logic.increase();
    _update();
  }

  void onDecrease() {
    _logic.decrease();
    _update();
  }

  void onReset() {
    _logic.reset();
    _update();
  }

  void _update() {
    CountData oldValue = _ref.watch(countDataProvider);
    _ref.watch(countDataProvider.notifier).update(
          (state) => _logic.countData,
        );
    CountData newValue = _ref.watch(countDataProvider);

    // notifiers
    notifiers.forEach((element) => element.valueChanged(oldValue, newValue));
  }
}
