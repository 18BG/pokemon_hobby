import 'pokemon.dart';

class HData {
  PokemonListData? data;

  HData({required this.data});

  HData.initial() : data = null;

  HData copyWith({PokemonListData? data}) {
    return HData(data: data ?? this.data);
  }
}
