import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:zconverter/HomePage.dart';

class TTS extends StatefulWidget {
  const TTS({super.key});
  @override
  State<TTS> createState() => _TTSState();
}

enum TtsState { playing, stoped, paused, resumed }

class _TTSState extends State<TTS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.tts,
          style: GoogleFonts.inconsolata(
            color: Theme.of(context).bottomAppBarColor,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ////////////////////////////////////////////////////
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: 0.8,
              child: ClipPath(
                clipper: PageClipper(),
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(0, 15, 10, 10),
                  color: Theme.of(context).shadowColor,
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.text_one,
                        style: GoogleFonts.inconsolata(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.text_two,
                        style: GoogleFonts.inconsolata(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ///////////////////////////////////

            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                //height: 200,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 198, 226, 222)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 5), // changes position of shadow
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
                    TextField(
                      minLines: 1,
                      maxLines: null,
                      readOnly: false,
                      controller: textController,
                      onChanged: ((value) {
                        setState(() {
                          _tts = value;
                        });
                      }),
                      enableInteractiveSelection: true,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.hint_one,
                        hintStyle: TextStyle(
                          color: Theme.of(context).bottomAppBarColor,
                        ),
                      ),
                      style: const TextStyle(
                          // color: Color.fromRGBO(8, 31, 29, 1.000),
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 3,
                    ), //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            String _text = textController.text;
                            if (_text.isEmpty) {
                              SnackBar(
                                content: Text(
                                  'Nothing to copy !',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).bottomAppBarColor),
                                ),
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                              );
                            } else {
                              Clipboard.setData(
                                      ClipboardData(text: textController.text))
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Copied to your clipboard !',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .bottomAppBarColor),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                  ),
                                );
                              });
                            }
                          },
                          icon: const Icon(Icons.copy),
                        ),
                        //
                        const SizedBox(
                          width: 50,
                        ),
                        //
                        IconButton(
                            onPressed: () {
                              textController.clear();
                            },
                            icon: const Icon(Icons.clear)),
                      ],
                    ),
                    //
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: const Color.fromRGBO(170, 216, 210, 1.000)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // pause and resume icon button
                          IconButton(
                              icon: Icon(TtsButton),
                              onPressed: () {
                                if (_ttsState == TtsState.paused) {
                                  setState(() {
                                    Resume();
                                    TtsButton = Icons.pause_rounded;
                                  });
                                } else {
                                  setState(() {
                                    Pause();
                                    TtsButton = Icons.play_arrow;
                                  });
                                }
                              }),

                          ///play icon button
                          IconButton(
                              icon: const Icon(Icons.play_circle_outline),
                              onPressed: () {
                                if (_ttsState == TtsState.stoped) {
                                  setState(() {
                                    Speak();
                                  });
                                } else {
                                  setState(() {
                                    Speak();
                                  });
                                }
                              }),

                          //stop icon button
                          IconButton(
                            icon: const Icon(Icons.stop),
                            onPressed: () {
                              Stop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Set language lists

  late List _setLanguage = [
    {'name': 'Amharic'},
    {'name': 'English'},
  ];

  //tts

  late FlutterTts _flutterTts;
  String? _tts;
  final TextEditingController textController = TextEditingController();
  TtsState _ttsState = TtsState.stoped;
  IconData TtsButton = Icons.pause;

  @override
  void initState() {
    super.initState();
    initTts();
  }

  initTts() async {
    _flutterTts = FlutterTts();
    await _flutterTts.awaitSpeakCompletion(true);
    _flutterTts.setStartHandler(() {
      setState(() {
        print('Playing');
        _ttsState = TtsState.playing;
      });
    });
    _flutterTts.setCompletionHandler(() {
      setState(() {
        print('Complite');
        _ttsState = TtsState.stoped;
      });
    });
    _flutterTts.setContinueHandler(() {
      setState(() {
        _ttsState = TtsState.resumed;
      });
    });
    _flutterTts.setPauseHandler(() {
      setState(() {
        _ttsState = TtsState.paused;
      });
    });
    _flutterTts.setCancelHandler(() {
      setState(() {
        print('Cancelled');
        _ttsState = TtsState.stoped;
      });
    });
    _flutterTts.setErrorHandler((message) {
      setState(() {
        print('Error: $message');
        _ttsState = TtsState.stoped;
      });
    });
  }

  Speak() async {
    await _flutterTts.getLanguages;
    await _flutterTts.setVolume(1);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1);
    await _flutterTts.setLanguage('en-US');

    if (_tts != null) {
      if (_tts!.isNotEmpty) {
        await _flutterTts.speak(_tts!);
      }
    }
  }

  Pause() {
    var result = _flutterTts.pause();
    if (result == 1) {
      setState(() {
        _ttsState = TtsState.paused;
      });
    }
  }

  Resume() {
    var result = _flutterTts.speak(textController.text);
    if (result == 1) {
      setState(() {
        _ttsState = TtsState.resumed;
      });
    }
  }

  void Stop() async {
    var result = _flutterTts.stop();
    if (result == 1) {
      setState(() {
        _ttsState = TtsState.stoped;
      });
    }
  }
}

/*
//another method
_Speak() async {
    //List<String>? voices = await tts.getVoice();

    // String language = 'en-US';
    List<String>? voices = await _flutterTts.getVoiceByLang('en');

    await _flutterTts.setVolume(1);
    await _flutterTts.setPitch(1);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setLanguage('en');
    await _flutterTts.speak(textController.text);
  }

  _Stop() async {
    var result = _flutterTts.stop();

    if (result == 1) {
      setState(() {
       _flutterTts.stop();
      });
    }
  }
*/

/*var locales = await speech.locales();

// Some UI or other code to select a locale from the list
// resulting in an index, selectedLocale

var selectedLocale = locales[selectedLocale];
speech.listen(
    onResult: resultListener,
    localeId: selectedLocale.localeId,
    );
    */
