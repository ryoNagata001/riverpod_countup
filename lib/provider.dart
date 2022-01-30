import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_countup/data/count_data.dart';

// 定数
final titleProvider = Provider<String>((_) => 'Riverpod Demo Home Page');
final messageProvider = Provider<String>((_) => 'あなたがボタンを押した回数');
// 変数
final countProvider = StateProvider<int>((ref) => 0);
final countDataProvider = StateProvider<CountData>((ref) => const CountData(count: 0, countUp: 0, countDown: 0)); // 初期値が入っている
