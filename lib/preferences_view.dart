import 'package:flutter/material.dart';
import 'package:motah/widgets/language_button_change.dart';
import 'package:motah/widgets/theme_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:motah/widgets/widgets.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Image.asset(
                'assets/motah_logo.jpeg',
                height: 150,
              ),
          Text(AppLocalizations.of(context)!.user_preference, style: Theme.of(context).textTheme.displayLarge,),
              // change language button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.arabic, style: Theme.of(context).textTheme.displaySmall,),
                  ChangeLanguageButton(),
                ],
              ),
              // change theme button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.dark_mode, style: Theme.of(context).textTheme.displaySmall,),
                  ChangeThemeButtonWidget(),
                ],
              ),
        ],
      ),
    );
  }
}