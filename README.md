# global_app
Flutter3.10.0で多言語対応をやってみた

使用したパッケージ
- flutter_localization: ^0.1.10
- intl: ^0.18.0
- shared_preferences: ^2.1.2

## 設定をする
1. libディレクトリにl10nディレクトリを作成する
2. app_en.arbとapp_ja.arbを作成する。enは英語で、jaは日本語, app_hi.arbも作ってみた。こちらはヒンディー語。
3. app_[言語].arbを作成したらターミナルで、コマンドを入力して、ファイルを自動生成する。

```
flutter gen-l10n
```
4. .dart_tool/flutter_genにファイルが自動生成される。
5. main.dartに言語を選択できるようにする設定を追加する。shared_preferences: ^2.1.2を使用して、切り替えて言語の設定を保存できるようにしているので、アプリを停止しても状態が保存されている。