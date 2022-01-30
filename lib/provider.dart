import 'package:hooks_riverpod/hooks_riverpod.dart';

// 定数
final titleProvider = Provider<String>((_) => 'Riverpod Demo Home Page');
final messageProvider = Provider<String>((_) => 'あなたがボタンを押した回数');
// 変数
final countProvider = StateProvider<int>((ref) => 0);
