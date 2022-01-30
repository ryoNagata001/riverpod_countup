import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_countup/logic/logic.dart';
import 'package:riverpod_countup/logic/sound_logic.dart';
import 'package:riverpod_countup/provider.dart';

import 'data/count_data.dart';

class ViewModel {
  final Logic _logic = Logic();
  final SoundLogic _soundLogic = SoundLogic();

  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
    _soundLogic.load();
  }

  get count => _ref.watch(countDataProvider.select((value) => value.count)).toString();
  get countUp => _ref.watch(countDataProvider.select((value) => value.countUp)).toString();
  get countDown => _ref.watch(countDataProvider.select((value) => value.countDown)).toString();

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
    _ref.watch(countDataProvider.notifier).update((state) => _logic.countData);
    CountData newValue = _ref.watch(countDataProvider);
    _soundLogic.valueChanged(oldValue, newValue);
  }
}
