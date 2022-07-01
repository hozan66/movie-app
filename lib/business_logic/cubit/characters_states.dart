import 'package:flutter/foundation.dart';

import '../../data/models/character.dart';
import '../../data/models/quote.dart';

@immutable
abstract class CharactersStates {}

class CharactersInitialState extends CharactersStates {}

class CharactersLoadedState extends CharactersStates {
  final List<Character> characters;
  CharactersLoadedState(this.characters);
}

class CharacterQuotesLoadedState extends CharactersStates {
  final List<Quote> quotes;
  CharacterQuotesLoadedState(this.quotes);
}
