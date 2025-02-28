import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/screens/models/pokemon.dart';
import 'package:pokemon_app/services/dio_service.dart';

final pokedateProvider = FutureProvider.family<Pokemon?, String>((
  ref,
  url,
) async {
  DioService _dioService = GetIt.instance.get();

  Response? response = await _dioService.fetch(url);

  if (response != null && response.data != null) {
    return Pokemon.fromJson(response.data);
  }
  return null;
});

final favoriteOkProvider = StateNotifierProvider((ref) {
  return FavoritePokemonProvider([]);
});

class FavoritePokemonProvider extends StateNotifier<List<String>> {
  FavoritePokemonProvider(super._state) {
    _setup();
  }
  _setup() async {}
}
