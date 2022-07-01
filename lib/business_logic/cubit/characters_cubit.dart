import 'package:flutter_bloc/flutter_bloc.dart';
import 'characters_states.dart';
import '../../data/models/character.dart';
import '../../data/repository/characters_repository.dart';

// All logic is here
class CharactersCubit extends Cubit<CharactersStates> {
  final CharactersRepository charactersRepository;
  List<Character> allCharacters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitialState());

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoadedState(characters)); // Send Data
      allCharacters = characters;
    });
    return allCharacters;
  }

  void getCharacterQuotes(String charName) {
    charactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(CharacterQuotesLoadedState(quotes)); // Send Data
    });
  }
}
