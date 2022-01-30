import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_countup/provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // riverpodから取得している
        title: Text(ref.watch(titleProvider)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(ref.watch(messageProvider)),
            Text(
              ref.watch(countProvider).toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  // watchではなくreadを使うことで、providerに変更があった場合でも、WidgetTreeが再構築されなくなる
                  onPressed: () => ref.read(countProvider.notifier).update((count) => count + 1),
                  child: const Icon(CupertinoIcons.plus),
                ),
                FloatingActionButton(
                  // watchではなくreadを使うことで、providerに変更があった場合でも、WidgetTreeが再構築されなくなる
                  onPressed: () => ref.read(countProvider.notifier).update((count) => count - 1),
                  child: const Icon(CupertinoIcons.minus),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('1'),
                Text('2'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // watchではなくreadを使うことで、providerに変更があった場合でも、WidgetTreeが再構築されなくなる
        onPressed: () => ref.read(countProvider.notifier).update((count) => count + 1),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
