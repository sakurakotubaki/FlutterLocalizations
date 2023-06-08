import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_app/language.dart';

final counterProvider =
    NotifierProvider<CounterNotifier, int>(CounterNotifier.new);

class CounterNotifier extends Notifier<int> {
  @override
  build() {
    return 0;
  }

  void increment() {
    state++;
  }
}

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider);
    return MaterialApp(
      locale: locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('hi'),
        Locale('ja'),
      ],
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider);
    final localeName = locale.toLanguageTag();
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(AppLocalizations.of(context).helloWorld),
        actions: [
          DropdownButton<String>(
            value: localeName,
            onChanged: (String? languageCode) {
              if (languageCode != null) {
                ref.read(languageProvider.notifier).setLanguage(languageCode);
              }
            },
            items: <String>['en', 'hi', 'ja']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$counter',
              style: TextStyle(fontSize: 50),
            ),
            Text(AppLocalizations.of(context).countMsg),
          ],
        ),
      ),
    );
  }
}
