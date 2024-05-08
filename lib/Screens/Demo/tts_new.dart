import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

class TTSScreen extends StatefulWidget {
  const TTSScreen({super.key});

  @override
  State<TTSScreen> createState() => _TTSScreenState();
}

class _TTSScreenState extends State<TTSScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextToSpeech _tts = TextToSpeech();
  String text =
      "Lorem Ipsum is simply dummy text. of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software. like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text. of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software. like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text. of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software. like Aldus PageMaker including versions of Lorem Ipsum.";

  double volume = 1;
  double rate = 1.0;
  double pitch = 1.0;

  int _highlightedIndex = 0;
  bool get supportPause => defaultTargetPlatform != TargetPlatform.android;

  bool get supportResume => defaultTargetPlatform != TargetPlatform.android;
  List<String> sentences = [];
  int currentSentenceIndex = 0;

  @override
  void initState() {
    super.initState();
    _tts.setLanguage("en-US"); // Set your desired language code here
    sentences = text.split('. '); // Split text into sentences
  }

  Future<void> speakWithHighlight() async {
    for (int i = 0; i < sentences.length; i++) {
      final sentence = sentences[i];

      setState(() {
        _highlightedIndex = i;
      });

      await _tts.setRate(rate);
      await _tts.setPitch(pitch);
      await _tts.setVolume(volume);
      await _tts.speak(sentence);

      // Calculate the approximate time needed for the sentence to be spoken
      final sentenceWords = sentence.split(' ');
      final speakingDuration = Duration(seconds: sentenceWords.length ~/ 2);

      // Delay the next sentence by the speaking duration
      // await Future.delayed(speakingDuration);
      if (i < sentences.length - 1) {
        await Future.delayed(speakingDuration);
      }
      // Scroll to the next sentence
      _scrollToNextSentence();
    }
  }

  void _scrollToNextSentence() {
    final double lineHeight = 30.0; // Adjust based on your text size
    final double scrollToY = currentSentenceIndex * lineHeight;
    _scrollController.animateTo(
      scrollToY,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    currentSentenceIndex++;
  }


  @override
  void dispose() {
    _scrollController.dispose();
    // _tts.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text-to-Speech with Auto Scroll and Highlight'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: sentences.length,
        itemBuilder: (context, index) {
          final sentence = sentences[index];
          return GestureDetector(
            onTap: () {
              // Highlight the sentence and scroll to it when tapped
              setState(() {
                _highlightedIndex = index;
              });
              _scrollToNextSentence();
            },
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: sentence,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: index == _highlightedIndex
                          ? Colors.blue // Highlighted text color
                          : Colors.black, // Regular text color
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              speakWithHighlight();
            },
            child: Icon(Icons.volume_up),
          ),
          SizedBox(
            height: 5,
          ),
          FloatingActionButton(
            onPressed: () {
              _tts.stop();
            },
            child: Icon(Icons.pause),
          ),
        ],
      ),
    );
  }
}
