import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motah/providers/locale_provider.dart';
import 'package:motah/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_app.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   SharedPreferences pref = await SharedPreferences.getInstance();
  bool? isDark = pref.getBool("isDark") ?? false;
  bool? isArabic= pref.getBool("isArabic") ?? false;
  print(pref.getKeys());
  runApp(MultiProvider(providers: [
     ChangeNotifierProvider<ThemeProvider>(
          create: (context) =>
              ThemeProvider(isDark ? ThemeMode.dark : ThemeMode.light),
        ),
    ChangeNotifierProvider<LocaleProvider>(
          create: (context) =>
              LocaleProvider(isArabic ? Locale("ar") : Locale("en")),
        ),
  ], child: Motah()));
}
