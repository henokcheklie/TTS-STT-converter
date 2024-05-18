// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zconverter/HomePage.dart';
import 'package:zconverter/LanguageList.dart';
//////////////////////////////////////////////////////////////////////

class STT extends StatefulWidget {
  const STT({super.key});
  @override
  State<STT> createState() => _STTState();
}

class _STTState extends State<STT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.stt,
          style: GoogleFonts.inconsolata(
            color: Theme.of(context).bottomAppBarColor,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        endRadius: 80,
        duration: const Duration(milliseconds: 2000),
        glowColor: const Color.fromRGBO(106, 186, 177, 1.000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: () {
            if (_isListening) {
              _stopListening();
              _isListening = false;
            } else {
              _Listen();
              Icons.mic_off;
            }
          },
          child: Icon(_isListening ? Icons.mic : Icons.mic_off),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Opacity(
              opacity: 0.8,
              child: ClipPath(
                clipper: PageClipper(),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(0, 15, 10, 10),
                  color: Theme.of(context).shadowColor,
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            ),
            //////////////////////////
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
              child: Container(
                //height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(170, 216, 210, 1.000),
                  ),
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
                      //enabled: false,
                      minLines: 1,
                      maxLines: null,
                      readOnly: true,
                      controller: textController1,
                      enableInteractiveSelection: true,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        //enabled: true,
                        hintText: AppLocalizations.of(context)!.hint_two,
                        hintStyle: TextStyle(
                          color: Theme.of(context).bottomAppBarColor,
                        ),
                        suffixIcon: Column(
                          children: [],
                        ),
                      ),
                      style: const TextStyle(
                          //color: Color.fromRGBO(8, 31, 29, 1.000),
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropdownButton(
                            hint: Text(AppLocalizations.of(context)!.language),
                            isExpanded: false,
                            //value: changedLanguage,
                            onChanged: (selectedValue) {
                              _changeLanguage(selectedValue);
                            },
                            items: Language.setLanguage()
                                .map<DropdownMenuItem>((map) {
                              return DropdownMenuItem(
                                value: map,
                                child: Text(map.name),
                              );
                            }).toList()),
                        //
                        SizedBox(
                          width: 50,
                        ),
                        //
                        IconButton(
                          onPressed: () {
                            String _text = textController1.text;
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
                                      ClipboardData(text: textController1.text))
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
                              textController1.clear();
                            },
                            icon: const Icon(Icons.clear)),
                      ],
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

//change language
  void _changeLanguage(Language selectedValue) {
    switch (selectedValue.languageCode) {
      case 'am':
        changedId = 'am';
        break;
      case 'en':
        changedId = 'en';
        break;
      default:
        changedId = 'en';
    }
  }

//speech to text
  @override
  void dispose() {
    textController1.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _initSpeech();
    _speechToText = stt.SpeechToText();
  }

  TextEditingController textController1 = TextEditingController();
  stt.SpeechToText _speechToText = stt.SpeechToText();
  late String changedId;
  bool _isListening = false;

  void _Listen() async {
    if (!_isListening) {
      bool Available = await _speechToText.initialize(
        onStatus: (status) => print('$status'),
        onError: (errorNotification) => print('onError: $errorNotification'),
      );
      if (Available) {
        setState(() {
          _isListening = true;
        });
        _speechToText.listen(
          //localeId: _currentLocaleId,
          localeId: changedId,
          listenFor: const Duration(minutes: 30),
          onResult: (result) => setState(() {
            textController1.text = result.recognizedWords;
          }),
        );
      } else {
        setState(() {
          _isListening = false;
          _speechToText.stop();
          textController1.text = "";
        });
      }
    }
  }

  //for manually stoping
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }
}
