import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/providers/poke_data_provider.dart';
import 'package:pokemon_app/screens/models/pokemon.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Items extends ConsumerWidget {
  final String pokeUrl;
  const Items({super.key, required this.pokeUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokedateProvider(pokeUrl));
    return pokemon.when(
      data: (data) {
        return element(context, false, data);
      },
      error: (error, strace) {
        return Text("Error occured : $error");
      },
      loading: () {
        return element(context, true, null);
      },
    );
  }

  Widget element(BuildContext context, bool isLoading, Pokemon? pk) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListTile(
        leading:
            pk != null
                ? CircleAvatar(
                  backgroundImage: NetworkImage(pk.sprites!.frontDefault!),
                )
                : CircleAvatar(),
        title: Text(
          pk != null
              ? pk.name!.toUpperCase()
              : "Loading data, be patient some moment...",
        ),
        subtitle: Text("${pk?.moves?.length ?? 0} moves availabe"),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border),
        ),
      ),
    );
  }
}
