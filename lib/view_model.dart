import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_countup/logic.dart';
import 'package:riverpod_countup/provider.dart';

class ViewModel {
  final Logic _logic = Logic();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  get count => _ref.watch(countDataProvider.select((value) => value.count)).toString();
  get countUp => _ref.watch(countDataProvider.select((value) => value.countUp)).toString();
  get countDown => _ref.watch(countDataProvider.select((value) => value.countDown)).toString();

  void onIncrease() {
    _logic.increase();
    _notify();
  }

  void onDecrease() {
    _logic.decrease();
    _notify();
  }

  void onReset() {
    _logic.reset();
    _notify();
  }

  void _notify() {
    _ref.watch(countDataProvider.notifier).update((state) => _logic.countData);
  }
}
