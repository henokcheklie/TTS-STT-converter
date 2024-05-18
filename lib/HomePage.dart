import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:zconverter/ForTheme/ThemeSetUp.dart';
import 'package:zconverter/STT.dart';
import 'package:zconverter/TTS.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, ModelTheme themeNotifier, child) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Opacity(
                  opacity: 0.8,
                  child: ClipPath(
                    clipper: PageClipper(),
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                      color: Theme.of(context).shadowColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 100,
                            //width: 160,
                            padding: EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.text_three,
                                  style: GoogleFonts.inconsolata(
                                    color: Theme.of(context).cardColor,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AnimatedTextKit(
                                  animatedTexts: [
                                    WavyAnimatedText(
                                      AppLocalizations.of(context)!.text_four,
                                      textStyle: GoogleFonts.inconsolata(
                                        color: Theme.of(context).cardColor,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          /////////////////////////////
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                            alignment: Alignment.topRight,
                            height: 100,
                            width: 100,
                            child: IconButton(
                              color: Theme.of(context)
                                  .cardColor, //Theme.of(context).cardColor,
                              onPressed: () {
                                themeNotifier.isDark
                                    ? themeNotifier.isDark = false
                                    : themeNotifier.isDark = true;
                              },
                              icon: Icon(themeNotifier.isDark
                                  ? Icons.wb_sunny
                                  : Icons.nightlight_round),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ////////////////////////////////////
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.text_five,
                        style: GoogleFonts.dancingScript(
                          textStyle: Theme.of(context).textTheme.headline4,
                          color: Theme.of(context).bottomAppBarColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //
                      Text(
                        AppLocalizations.of(context)!.text_six,
                        style: GoogleFonts.inconsolata(
                          textStyle: Theme.of(context).textTheme.headline4,
                          color: Theme.of(context).bottomAppBarColor,
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 200,
                            width: 150,
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 198, 226, 222)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 120,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('assets/images.png'),
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TTS()));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.tts,
                                    style: GoogleFonts.inconsolata(
                                      textStyle:
                                          Theme.of(context).textTheme.headline4,
                                      color:
                                          Theme.of(context).bottomAppBarColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ////////////////////////////////
                          Container(
                            height: 200,
                            width: 150,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 198, 226, 222)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 120,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('assets/stt.png'),
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => STT()));
                                  },
                                  child: Text(AppLocalizations.of(context)!.stt,
                                      style: GoogleFonts.inconsolata(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        color:
                                            Theme.of(context).bottomAppBarColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //////////////////////////////////
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class PageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    //debugPrint(size.width.toString());

    var path = new Path();
    path.lineTo(0, size.height); //initial point
    var firtsStart = Offset(size.width / 5, size.height); //first curve etarts
    var firstEnd =
        Offset(size.width / 2.25, size.height - 50); //fitst curve end
    path.quadraticBezierTo(
        firtsStart.dx, firtsStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart = Offset(size.width - (size.width / 3.24),
        size.height - 105); //second curve etarts
    var secondEnd = Offset(size.width, size.height - 10); //second curve end
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
