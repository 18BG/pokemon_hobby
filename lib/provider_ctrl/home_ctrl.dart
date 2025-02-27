import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/screens/models/pokemon.dart';
import 'package:pokemon_app/screens/models/screen_data.dart';
import 'package:pokemon_app/services/dio_service.dart';

class HomeCtrl extends StateNotifier<HData> {
  final GetIt _getIt = GetIt.instance;

  late DioService _dioService;

  HomeCtrl(super._state) {
    _dioService = _getIt.get<DioService>();
    _dioService = _getIt.get();
    _appreter();
  }

  Future<void> _appreter() async {
    chargeInfos();
  }

  Future<void> chargeInfos() async {
    if (state.data == null) {
      Response? res = await _dioService.fetch(
        "https://pokeapi.co/api/v2/pokemon?limit=5&offset=0",
      );
      if (res != null) {
        PokemonListData pkemon = PokemonListData.fromJson(res.data);
        state = state.copyWith(data: pkemon);
        debugPrint("${pkemon.results}");
      }
    } else {}
  }
}
