import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zconverter/ForTheme/ThemeSetUp.dart';
import 'package:zconverter/main.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String _selectedItem = 'Light';
  final List<String> _themeList = ['Light', 'Dark'];
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.setting,
            style: GoogleFonts.inconsolata(
              color: Theme.of(context).bottomAppBarColor,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                children: [
                  const Icon(Icons.language),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: GoogleFonts.roboto(
                      color: Theme.of(context).bottomAppBarColor,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.amharic,
                style: GoogleFonts.roboto(
                  color: Theme.of(context).bottomAppBarColor,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              leading: const Text(
                '🇪🇹',
              ),
              onTap: () {
                setState(() {
                  MyApp.setLocale(
                      context, const Locale.fromSubtags(languageCode: 'am'));
                });
              },
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.english,
                style: GoogleFonts.roboto(
                  color: Theme.of(context).bottomAppBarColor,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              leading: const Text(
                '🇺🇸',
              ),
              onTap: () {
                MyApp.setLocale(
                    context, const Locale.fromSubtags(languageCode: 'en'));
              },
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              decoration: const BoxDecoration(
                  //color: Color.fromRGBO(212, 235, 233, 1.000),
                  ),
              child: Row(
                children: [
                  const Icon(Icons.brightness_6),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: GoogleFonts.roboto(
                      color: Theme.of(context).bottomAppBarColor,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.light_theme,
                style: GoogleFonts.roboto(
                  color: Theme.of(context).bottomAppBarColor,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              leading: const Icon(Icons.wb_sunny),
              onTap: () {
                themeNotifier.isDark = false;
              },
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.dark_theme,
                style: GoogleFonts.roboto(
                  color: Theme.of(context).bottomAppBarColor,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              leading: const Icon(Icons.nightlight_round),
              onTap: () {
                themeNotifier.isDark = true;
              },
            ),
            //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  });
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  decoration: const BoxDecoration(
                      //color: Color.fromRGBO(212, 235, 233, 1.000),
                      ),
                  child: Row(children: [
                    const Icon(Icons.exit_to_app),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.exit,
                      style: GoogleFonts.roboto(
                        color: Theme.of(context).bottomAppBarColor,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ]),
                )),
            //
          ],
        ),
      );
    });
  }
}
