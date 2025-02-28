import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/provider_ctrl/home_ctrl.dart';
import 'package:pokemon_app/screens/models/pokemon.dart';
import 'package:pokemon_app/screens/models/screen_data.dart';
import 'package:pokemon_app/widgets/items.dart';

final homeCtrlProvider = StateNotifierProvider((ref) {
  return HomeCtrl(HData.initial());
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late HomeCtrl _homeCtrl;
  late HData _hData;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollEnd);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollEnd);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScrollEnd() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent * 1 &&
        !_scrollController.position.outOfRange) {
      _homeCtrl.chargeInfos();
      print("Get more data");
    }
  }

  @override
  Widget build(BuildContext context) {
    _homeCtrl = ref.watch(homeCtrlProvider.notifier);
    _hData = ref.watch(homeCtrlProvider);
    return Scaffold(body: _buildUI(context));
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.02,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_allPokemonList(context)],
          ),
        ),
      ),
    );
  }

  Widget _allPokemonList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Lists of Pokemons", style: TextStyle(fontSize: 25)),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.60,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _hData.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
                PokemonListResult poke = _hData.data!.results![index];
                return Items(pokeUrl: poke.url!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
