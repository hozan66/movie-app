import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../business_logic/cubit/characters_states.dart';
import '../../constants/my_colors.dart';
import '../../data/models/quote.dart';

import '../../data/models/character.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
        expandedHeight: 600.0,
        pinned: true,
        stretch: true,
        backgroundColor: MyColors.myGrey,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            character.nickName,
            style: const TextStyle(color: MyColors.myWhite),
            // textAlign: TextAlign.start,
          ),
          background: Hero(
            tag: character.charId,
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      // RichText widget gave more control on text
      maxLines: 1,
      overflow:
          TextOverflow.ellipsis, // If the text is long it shows 3 dots ...
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30.0,
      endIndent: endIndent, // Yellow line
      color: MyColors.myYellow,
      thickness: 2.0,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersStates state) {
    if (state is CharacterQuotesLoadedState) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(CharacterQuotesLoadedState state) {
    List<Quote> charQuotes = state.quotes;
    if (charQuotes.isNotEmpty) {
      int randomQuoteIndex = Random().nextInt(charQuotes.length);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: MyColors.myYellow,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
          child: AnimatedTextKit(repeatForever: true, animatedTexts: [
            FlickerAnimatedText(charQuotes[randomQuoteIndex].quote),
          ]),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // BlocProvider is lazy be default
    // With the below line we make BlocProvider awake
    BlocProvider.of<CharactersCubit>(context)
        .getCharacterQuotes(character.name);
    return Scaffold(
      // We do not need AppBar Here
      backgroundColor: MyColors.myGrey,

      // The Name of character becomes an APPBar
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(), // Control the image and the name of the character

          // SliverList() widget Control the content of the character
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 0.0),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Job : ', character.jobs.join(' / ')),
                      buildDivider(315.0),
                      characterInfo(
                          'Appeared in : ', character.categoryForTwoSeries),
                      buildDivider(250.0),
                      characterInfo('Seasons : ',
                          character.appearanceOfSeasons.join(' / ')),
                      buildDivider(280.0),
                      characterInfo('Status : ', character.statusIfDeadOrAlive),
                      buildDivider(300.0),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo('Better Call Saul Seasons : ',
                              character.betterCallSaulAppearance.join(' / ')),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : buildDivider(150.0),
                      characterInfo('Actor/Actress : ', character.actorName),
                      buildDivider(235.0),
                      const SizedBox(
                        height: 20.0,
                      ),
                      BlocBuilder<CharactersCubit, CharactersStates>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
