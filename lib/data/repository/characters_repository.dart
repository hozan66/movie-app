import '../models/character.dart';
import '../models/quote.dart';
import '../web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();

    return characters
        .map((character) => Character.fromJson(character))
        .toList(); // Here data is list of Character
  }

  Future<List<Quote>> getCharacterQuotes(String charName) async {
    final quotes = await charactersWebServices.getCharacterQuotes(charName);

    return quotes
        .map((charQuote) => Quote.fromJson(charQuote))
        .toList(); // Here data is list of Quote
  }
}
