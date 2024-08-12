import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/presentation/home/cubits/story_cubit/story_cubit.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData _kMagicWand =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  int _currentChapterIndex = 0;
  String _words = '';

  @override
  Widget build(BuildContext context) {
    final TextEditingController _storyController = TextEditingController();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: LayoutBuilder(builder: (context, constraints) {
            return Padding(
              padding:
                  EdgeInsets.all(constraints.maxWidth > 1024 ? 20.0 : 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: AppColors.kLightGreyColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Tell me a story about...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      constraints.maxWidth > 1024 ? 30 : 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(width: constraints.maxWidth / 10),
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: _storyController,
                                  cursorColor: AppColors.kLightGreyColor,
                                  style: TextStyle(
                                    color: AppColors.kLightGreyColor,
                                    fontSize: constraints.maxWidth > 1024
                                        ? 20
                                        : 15, // Change this to your desired text color
                                  ),
                                  decoration: InputDecoration(
                                    hintText: _words.isNotEmpty
                                        ? _words
                                        : 'a bear on a summer trip to Brazil',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors
                                              .kLightGreyColor), // Change this to your desired border color
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors
                                              .kLightGreyColor), // Change this to your desired border color when focused
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                  ),
                                ),
                              ),
                              SizedBox(width: constraints.maxWidth / 10),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<StoryCubit>()
                                      .createStory(_storyController.text);
                                  setState(() {
                                    _currentChapterIndex = 0;
                                    _words = _storyController.text;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 5,
                                  fixedSize: constraints.maxWidth > 1024
                                      ? const Size(60, 60)
                                      : const Size(40, 40),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Center(
                                  child: Icon(
                                    _kMagicWand,
                                    size: constraints.maxWidth > 1024 ? 30 : 20,
                                    color: AppColors.kLightGreyColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: constraints.maxWidth / 10),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: AppColors.kLightGreyColor,
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: BlocBuilder<StoryCubit, StoryState>(
                        builder: (context, state) {
                          if (state is StoryParsed) {
                            final chapters = state.story.chapters;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.story.title,
                                  style: TextStyle(
                                    fontSize:
                                        constraints.maxWidth > 1024 ? 30 : 20,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Chapter ${_currentChapterIndex + 1}: ${chapters[_currentChapterIndex].chapterTitle}',
                                    style: TextStyle(
                                      fontSize:
                                          constraints.maxWidth > 1024 ? 20 : 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      constraints.maxWidth > 1024 ? 300 : 200,
                                  child: const Divider(
                                    color: AppColors.kLightGreyColor,
                                    thickness: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60.0, vertical: 20),
                                      child: Text(
                                        chapters[_currentChapterIndex].content,
                                        style: TextStyle(
                                          fontSize: constraints.maxWidth > 1024
                                              ? 25
                                              : 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 40.0),
                                      child: ElevatedButton(
                                        onPressed: _currentChapterIndex > 0
                                            ? () {
                                                setState(() {
                                                  _currentChapterIndex--;
                                                });
                                              }
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.kPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 5,
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.arrow_back,
                                            size: 20,
                                            color: AppColors.kLightGreyColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 40.0),
                                      child: ElevatedButton(
                                        onPressed: _currentChapterIndex <
                                                chapters.length - 1
                                            ? () {
                                                setState(() {
                                                  _currentChapterIndex++;
                                                });
                                              }
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.kPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 5,
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: 20,
                                            color: AppColors.kLightGreyColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60.0, vertical: 20),
                                  child: Text(
                                    'Create a story! Enter the plot and click the magic button.',
                                    style: TextStyle(
                                      color: AppColors.kLightGreyColor
                                          .withOpacity(0.5),
                                      fontSize: constraints.maxWidth > 1024
                                          ? 30
                                          : constraints.maxWidth > 600
                                              ? 25
                                              : 20,
                                    ),
                                  ),
                                ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// : const CircularProgressIndicator(
//   color: AppColors.kPrimaryColor,
// ),
