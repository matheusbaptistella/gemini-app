import 'package:flutter/material.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  final List<String> words = [
    "Ecosystem", "Nature", "Sustainability", "Responsible",
    "Water", "Sapling", "Green", "Biodiversity",
    "Forest", "Ecological", "Humane", "Climate", "Life", "Tree",
  ];
  late final List<String> _loopedWords = [...words, ...words];
  final List<TextStyle> textStyles = [
    GoogleFonts.urbanist(
      color: AppColors.kPrimaryColor,
      fontWeight: FontWeight.w600,
      fontSize: 60,
      fontStyle: FontStyle.normal,
    ),
    GoogleFonts.urbanist(
      color: AppColors.kPrimaryColor,
      fontWeight: FontWeight.w700,
      fontSize: 57,
      fontStyle: FontStyle.normal,
    ),
    GoogleFonts.urbanist(
      color: AppColors.kPrimaryColor,
      fontWeight: FontWeight.w500,
      fontSize: 59,
      fontStyle: FontStyle.normal,
    ),
    GoogleFonts.urbanist(
      color: AppColors.kPrimaryColor,
      fontWeight: FontWeight.w800,
      fontSize: 58,
      fontStyle: FontStyle.italic,
    ),
  ];

  List<Widget> applyStyles(int startIndex) {
    return List<Widget>.generate(_loopedWords.length, (index) {
      int styleIndex = (startIndex + index) % textStyles.length;

      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          words[index % words.length],
          style: textStyles[styleIndex],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScrollingText(duration: const Duration(seconds: 50), begin: Offset.zero, end: const Offset(-2800, 0), texts: applyStyles(0)),
            ScrollingText(duration: const Duration(seconds: 40), begin: const Offset(-2800, 0), end: Offset.zero, texts: applyStyles(3)),
            ScrollingText(duration: const Duration(seconds: 70), begin: Offset.zero, end: const Offset(-2800, 0), texts: applyStyles(1)),
          ],
        ),
      ),
    );
  }
}

class ScrollingText extends StatefulWidget {
  const ScrollingText({super.key, required this.duration, required this.begin, required this.end, required this.texts});

  final Duration duration;
  final Offset begin;
  final Offset end;
  final List<Widget> texts;

  @override
  State<ScrollingText> createState() => _ScrollingTextState();
}

class _ScrollingTextState extends State<ScrollingText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation = _animation = Tween<Offset>(
    begin: widget.begin,
    end: widget.end,
  ).animate(_controller);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat()..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      clipBehavior: Clip.hardEdge,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black,
              Colors.black,
              Colors.transparent
            ],
            stops: [0.1, 0.3, 0.7, 0.9],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: Transform.translate(
          offset: _animation.value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.texts,
          ),
        ),
      ),
    );
  }
}