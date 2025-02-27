import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/provider_ctrl/home_ctrl.dart';
import 'package:pokemon_app/screens/models/screen_data.dart';

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
              itemCount: _hData.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(title: Text(index.toString()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
