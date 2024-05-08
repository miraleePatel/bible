import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class TTsDemoScreen extends StatefulWidget {
  const TTsDemoScreen({super.key});

  @override
  State<TTsDemoScreen> createState() => _TTsDemoScreenState();
}

class _TTsDemoScreenState extends State<TTsDemoScreen> {
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;
  String text =
      "The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'... "; // Your long text

  String? _newVoiceText;
  int? _inputLength;
  bool isPlaying1 = false;
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;
  ScrollController _scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
        isPlaying1 = true;
      });
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        setState(() {
          print("TTS Initialized");
        });
      });
    }

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
        isPlaying1 = false;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
        isPlaying1 = false;
      });
    });
  }

  Future<dynamic> _getLanguages() async => await flutterTts.getLanguages;

  Future<dynamic> _getEngines() async => await flutterTts.getEngines;

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    if (text != null && text.isNotEmpty) {
      var result = await flutterTts!.speak(text);
      if (result == 1) {
        setState(() {
          isPlaying1 = true;
        });
        // Scroll to the bottom when speech starts
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: text.length * 40),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1)
      setState(() {
        ttsState = TtsState.stopped;
        isPlaying1 = false;
      });
  }

  Future _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  List<DropdownMenuItem<String>> getEnginesDropDownMenuItems(dynamic engines) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in engines) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text(type as String)));
    }
    return items;
  }

  void changedEnginesDropDownItem(String? selectedEngine) async {
    await flutterTts.setEngine(selectedEngine!);
    language = null;
    setState(() {
      engine = selectedEngine;
    });
  }

  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
      dynamic languages) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in languages) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text(type as String)));
    }
    return items;
  }

  void changedLanguageDropDownItem(String? selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage(language!);
      if (isAndroid) {
        flutterTts
            .isLanguageInstalled(language!)
            .then((value) => isCurrentLanguageInstalled = (value as bool));
      }
    });
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter TTS'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _inputSection(),
              _btnSection(),
              _engineSection(),
              _futureBuilder(),
              _buildSliders(),
              if (isAndroid) _getMaxSpeechInputLengthSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _engineSection() {
    if (isAndroid) {
      return FutureBuilder<dynamic>(
          future: _getEngines(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return _enginesDropDownSection(snapshot.data);
            } else if (snapshot.hasError) {
              return Text('Error loading engines...');
            } else
              return Text('Loading engines...');
          });
    } else
      return Container(width: 0, height: 0);
  }

  Widget _futureBuilder() => FutureBuilder<dynamic>(
      future: _getLanguages(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _languageDropDownSection(snapshot.data);
        } else if (snapshot.hasError) {
          return Text('Error loading languages...');
        } else
          return Text('Loading Languages...');
      });

  Widget _inputSection() => Container(
        height: 200, // Adjust the height as needed
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Text(
            text,
            style: TextStyle(color: Colors.pink, fontSize: 20),
          ),
        ),
      );

  Widget _btnSection() {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.green, Colors.greenAccent, Icons.play_arrow,
              'PLAY', _speak),
          _buildButtonColumn(
              Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
          _buildButtonColumn(
              Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', _pause),
        ],
      ),
    );
  }

  Widget _enginesDropDownSection(dynamic engines) => Container(
        padding: EdgeInsets.only(top: 50.0),
        child: DropdownButton(
          value: engine,
          items: getEnginesDropDownMenuItems(engines),
          onChanged: changedEnginesDropDownItem,
        ),
      );

  Widget _languageDropDownSection(dynamic languages) => Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: language,
          items: getLanguageDropDownMenuItems(languages),
          onChanged: changedLanguageDropDownItem,
        ),
        Visibility(
          visible: isAndroid,
          child: Text("Is installed: $isCurrentLanguageInstalled"),
        ),
      ]));

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ]);
  }

  Widget _getMaxSpeechInputLengthSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: Text('Get max speech input length'),
          onPressed: () async {
            _inputLength = await flutterTts.getMaxSpeechInputLength;
            setState(() {});
          },
        ),
        Text("$_inputLength characters"),
      ],
    );
  }

  Widget _buildSliders() {
    return Column(
      children: [_volume(), _pitch(), _rate()],
    );
  }

  Widget _volume() {
    return Slider(
        value: volume,
        onChanged: (newVolume) {
          setState(() => volume = newVolume);
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "Volume: $volume");
  }

  Widget _pitch() {
    return Slider(
      value: pitch,
      onChanged: (newPitch) {
        setState(() => pitch = newPitch);
      },
      min: 0.5,
      max: 2.0,
      divisions: 15,
      label: "Pitch: $pitch",
      activeColor: Colors.red,
    );
  }

  Widget _rate() {
    return Slider(
      value: rate,
      onChanged: (newRate) {
        setState(() => rate = newRate);
      },
      min: 0.0,
      max: 1.0,
      divisions: 10,
      label: "Rate: $rate",
      activeColor: Colors.green,
    );
  }
}






/* import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSExampleWidget extends StatefulWidget {
  @override
  _TTSExampleWidgetState createState() => _TTSExampleWidgetState();
}

class _TTSExampleWidgetState extends State<TTSExampleWidget> {
  String text =
      "The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'...The first version of Flutter was known as codename 'Sky'... "; // Your long text

  bool isPlaying = false;
  FlutterTts? _flutterTts;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initializeTts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Text To Speech"),
          backgroundColor: Colors.pink,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Icon(
                  (isPlaying)
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  color: Colors.pink,
                  size: 48,
                ),
                onTap: () {
                  if (isPlaying) {
                    _stop();
                  } else {
                    _speak(text);
                  }
                },
              ),
              SizedBox(height: 10), // Add some spacing
              Container(
                height: 200, // Adjust the height as needed
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.pink, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  initializeTts() {
    _flutterTts = FlutterTts();

    _flutterTts!.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });

    _flutterTts!.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    _flutterTts!.setErrorHandler((err) {
      setState(() {
        print("error occurred: " + err);
        isPlaying = false;
      });
    });
  }

  Future _speak(String text) async {
    if (text != null && text.isNotEmpty) {
      var result = await _flutterTts!.speak(text);
      if (result == 1) {
        setState(() {
          isPlaying = true;
        });
        // Scroll to the bottom when speech starts
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: text.length * 40),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  Future _stop() async {
    var result = await _flutterTts!.stop();
    if (result == 1) {
      setState(() {
        isPlaying = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _flutterTts!.stop();
  }
} */

