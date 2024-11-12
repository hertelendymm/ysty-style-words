import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ysty_style_words/model/word_model.dart';

class ButtonTts extends StatefulWidget {
  const ButtonTts({
    super.key,
    required this.text,
    this.title="Button",
    this.backgroundColor=Colors.black,
    this.textColor=Colors.white,
    this.iconData = FontAwesomeIcons.xmark,
    this.iconColor = Colors.black,
  });

  final String text;
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final IconData iconData;
  final Color iconColor;

  @override
  State<ButtonTts> createState() => _ButtonTtsState();
}

class _ButtonTtsState extends State<ButtonTts> {

  bool _isTapped = false;
  FlutterTts _tts = FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
    _setUpTts();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tts.stop();
    super.dispose();
  }

  _setUpTts() async{
    await _tts.setLanguage("de-DE");
    await _tts.setSpeechRate(0.40);
  }

  _runTts() async{
    await _tts.speak(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _runTts();
        _isTapped = true;
        setState(() {});
        Future.delayed(Duration(milliseconds: 500),(){
          _isTapped = false;
          setState(() {});
        });

      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: widget.backgroundColor,
        ),
        padding: const EdgeInsets.all(20.0),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.iconData, color: widget.iconColor),
            const SizedBox(width: 10.0),
            Text(widget.title, style: TextStyle(color: widget.textColor, fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
