// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final languageProvider = StateNotifierProvider<LanguageController, Locale>(
    (ref) => LanguageController());

class LanguageController extends StateNotifier<Locale> {
  static const _keyLanguage = 'language';

  LanguageController() : super(Locale('ja')) {
    _fetchLocale();
  }

  void _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    var languageCode = prefs.getString(_keyLanguage) ?? 'ja';
    state = Locale(languageCode);
  }
  
  void setLanguage(String languageCode) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLanguage, languageCode);
    state = Locale(languageCode);
  }
}
