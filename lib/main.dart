import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_app/helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _fetchLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
  }

  Future<Locale> _fetchLocale() async {
    var languageCode = UserPreferences.getLanguage();
    return Locale(languageCode ?? 'ja'); // デフォルトを日本語に設定します
  }

  void _changeLanguage(String languageCode) async {
    await UserPreferences.setLanguage(languageCode); // 言語設定を保存します
    var locale = await _fetchLocale();
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      // Localeがまだ読み込まれていない場合は、ローディングスピナーを表示します
      return CircularProgressIndicator();
    } else {
      return MaterialApp(
        locale: _locale,
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
          onLanguageChanged: _changeLanguage,
        ),
      );
    }
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final ValueChanged<String> onLanguageChanged;

  MyHomePage({Key? key, required this.title, required this.onLanguageChanged})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(AppLocalizations.of(context).helloWorld),
        actions: [
          DropdownButton<String>(
            items: [
              DropdownMenuItem(value: "en", child: Text("English")),
              DropdownMenuItem(value: "ja", child: Text("日本語")),
              DropdownMenuItem(value: "hi", child: Text("हिंदी")),
            ],
            onChanged: (value) {
              widget.onLanguageChanged(value!);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).countMsg,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
