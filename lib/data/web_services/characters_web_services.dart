import 'package:dio/dio.dart';
import '../../constants/strings.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 20 seconds
      receiveTimeout: 20 * 1000,
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters'); // endpoints
      print("Response=${response.data.toString()}");
      return response.data; // Here data is list of map
    } catch (error) {
      print("Error=${error.toString()}");
      return [];
    }
  }

  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    try {
      Response response = await dio
          .get('quote', queryParameters: {'author': charName}); // endpoints
      print("Response=${response.data.toString()}");
      return response.data; // Here data is list of map
    } catch (error) {
      print("Error=${error.toString()}");
      return [];
    }
  }
}
