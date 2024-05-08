import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

class Tts extends StatefulWidget {
  const Tts({Key? key}) : super(key: key);

  @override
  State<Tts> createState() => _TtsState();
}

class _TtsState extends State<Tts> {
  final String defaultLanguage = 'en-US';
  ScrollController _scrollController = ScrollController();
  TextToSpeech tts = TextToSpeech();

  Color bgColor = const Color(0xff00A67E);

  String text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  double volume = 1; // Range: 0-1
  double rate = 1.0; // Range: 0-2
  double pitch = 1.0; // Range: 0-2

  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  String? voice;

  TextEditingController textEditingController = TextEditingController();

  bool get supportPause => defaultTargetPlatform != TargetPlatform.android;

  bool get supportResume => defaultTargetPlatform != TargetPlatform.android;

  void speak() {
    tts.setVolume(volume);
    tts.setRate(rate);
    if (languageCode != null) {
      tts.setLanguage(languageCode!);
    }
    tts.setPitch(pitch);
    tts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    textEditingController.text = text;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLanguages();
    });
  }

  Future<void> initLanguages() async {
    /// populate lang code (i.e. en-US)
    languageCodes = await tts.getLanguages();

    /// populate displayed language (i.e. English)
    final List<String>? displayLanguages = await tts.getDisplayLanguages();
    if (displayLanguages == null) {
      return;
    }

    languages.clear();
    for (final dynamic lang in displayLanguages) {
      languages.add(lang as String);
    }

    final String? defaultLangCode = await tts.getDefaultLanguage();
    if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
      languageCode = defaultLangCode;
    } else {
      languageCode = defaultLanguage;
    }
    language = await tts.getDisplayLanguageByCode(languageCode!);

    /// get voice
    voice = await getVoiceByLang(languageCode!);

    if (mounted) {
      setState(() {});
    }
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(languageCode!);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Text-to-Speech'),
          backgroundColor: bgColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: <Widget>[
              Container(
                    height: 100,
                child: ListView(
                  controller: _scrollController,
                  children: [
                    Container(height: 100,
                    child: Text(text),)
                  ],
                ),
              ),
                  Row(
                    children: <Widget>[
                      const Text('Volume'),
                      Expanded(
                        child: Slider(
                          value: volume,
                          min: 0,
                          max: 1,
                          activeColor: bgColor,
                          inactiveColor: bgColor.withOpacity(0.3),
                          label: volume.round().toString(),
                          onChanged: (double value) {
                            initLanguages();
                            setState(() {
                              volume = value;
                            });
                          },
                        ),
                      ),
                      Text('(${volume.toStringAsFixed(2)})'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Rate'),
                      Expanded(
                        child: Slider(
                          value: rate,
                          min: 0,
                          max: 2,
                          activeColor: bgColor,
                          inactiveColor: bgColor.withOpacity(0.3),
                          label: rate.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              rate = value;
                            });
                          },
                        ),
                      ),
                      Text('(${rate.toStringAsFixed(2)})'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Pitch'),
                      Expanded(
                        child: Slider(
                          value: pitch,
                          min: 0,
                          max: 2,
                          activeColor: bgColor,
                          inactiveColor: bgColor.withOpacity(0.3),
                          label: pitch.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              pitch = value;
                            });
                          },
                        ),
                      ),
                      Text('(${pitch.toStringAsFixed(2)})'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Language'),
                      const SizedBox(
                        width: 20,
                      ),
                      DropdownButton<String>(
                        value: language,
                        icon:  Icon(Icons.arrow_downward,color: bgColor,),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color:bgColor),
                        underline: Container(
                          height: 2,
                          color: bgColor,
                        ),
                        onChanged: (String? newValue) async {
                          languageCode =
                          await tts.getLanguageCodeByName(newValue!);
                          voice = await getVoiceByLang(languageCode!);
                          setState(() {
                            language = newValue;
                          });
                        },
                        items: languages
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Voice'),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(voice ?? '-'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(bgColor),
                            ),
                            child: const Text('Stop'),
                            onPressed: () {
                              tts.stop();
                            },
                          ),
                        ),
                      ),
                      if (supportPause)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(bgColor),
                              ),
                              child: const Text('Pause'),
                              onPressed: () {
                                tts.pause();
                              },
                            ),
                          ),
                        ),
                      if (supportResume)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(bgColor),
                              ),
                              child: const Text('Resume'),
                              onPressed: () {
                                tts.resume();
                              },
                            ),
                          ),
                        ),
                      Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(bgColor),
                            ),
                            child: const Text('Speak'),
                            onPressed: () {
                              speak();
                            },
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}