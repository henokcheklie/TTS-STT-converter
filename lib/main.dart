import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zconverter/ForTheme/ThemeSetUp.dart';
import 'package:zconverter/ForTheme/themes.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

//
import 'package:zconverter/STT.dart';
import 'package:zconverter/TTS.dart';
import 'package:zconverter/HomePage.dart';
import 'package:zconverter/setting.dart';
import 'package:zconverter/about.dart';
import 'package:dcdg/dcdg.dart';

////////////////////////////////////////////////////////////////////////
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  //set locale
  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findRootAncestorStateOfType<_MyAppState>();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('languageCode', newLocale.languageCode);
    await pref.setString('countryCode', "");
    state?.setState(() {
      state._locale = newLocale;
    });
  }

  @override
  _MyAppState creatState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en', 'am');

  @override
  void initState() {
    super.initState();
    this._fetchLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
  }

  Future<Locale> _fetchLocale() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String languageCode = pref.getString('languageCode') ?? 'en';
    String countryCode = pref.getString('countryCode') ?? 'US';
    return Locale(languageCode, countryCode);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return MaterialApp(
          builder: (context, child) => ResponsiveWrapper.builder(child,
              maxWidth: 1200,
              minWidth: 300,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(300, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
              background: Container(color: Color(0xFFF5F5F5))),
          //localization starts
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,
          //localization ends

          debugShowCheckedModeBanner: false,
          theme: themeNotifier.isDark ? darkTheme : lightTheme,
          home: AnimatedSplashScreen(
            splash: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  'HABESHA',
                  textStyle: GoogleFonts.aBeeZee(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              isRepeatingAnimation: true,
              onTap: () {
                print("Tap Event");
              },
            ),
            ///////////////////
            nextScreen: const WrapperPage(),
            duration: 2500,
            backgroundColor: const Color.fromRGBO(106, 186, 177, 1.000),
            splashTransition: SplashTransition.fadeTransition,
          ),
        );
      }));
}

class WrapperPage extends StatefulWidget {
  const WrapperPage({super.key});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 50,
        animationCurve: Curves.easeOut,
        color: Theme.of(context).backgroundColor,
        buttonBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Color.fromARGB(255, 206, 235, 233),
        items: const <Widget>[
          Icon(Icons.home),
          Icon(Icons.text_format),
          Icon(Icons.mic),
          Icon(Icons.settings),
          Icon(Icons.contact_support),
        ],
        onTap: (int value) {
          setState(() {
            _selectedIndex = value;
          });
          _pageController.jumpToPage(_selectedIndex);
        },
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: _PageLists,
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
            _pageController.jumpToPage(_selectedIndex);
          });
        },
      ),
      /*IndexedStack(
        index: _selectedIndex,
        children: _PageLists,
      ),*/
    );
  }

  @override
  void initState() {
    PageController _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final PageController _pageController = PageController();

  int _selectedIndex = 0;
  List<Widget> _PageLists = <Widget>[
    HomePage(),
    const TTS(),
    const STT(),
    const Setting(),
    const About(),
  ];
}
