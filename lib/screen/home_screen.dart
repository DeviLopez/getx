// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/main.dart';
import 'package:getx/modules/pokemon.dart';
import 'package:getx/providers/pokemonProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PokemonProvider c = Get.put(PokemonProvider());
    final List<Pokemon> pk = c.pokemons;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        elevation: 0,
      ),
      body: Obx(
        () => c.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: pk.length,
                itemBuilder: (BuildContext context, index) => SizedBox(
                  width: 200.0,
                  child: ListTile(
                    leading: Image.network(
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png",
                    ),
                    title: Text(
                      pk[index].name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        wordSpacing: 8,
                      ),
                    ),
                    trailing: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        wordSpacing: 8,
                      ),
                    ),
                    onTap: () {
                      if (c.equipo.length < 6) {
                        c.equipo.add(Pokemon(
                            name: pk[index].name,
                            url:
                                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png"));
                      } else {
                        Get.snackbar(
                          'Atención',
                          'Equipo completo',
                          backgroundColor: Color.fromARGB(98, 231, 231, 226),
                          barBlur: 5,
                        );
                      }
                    },
                  ),
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Botones(context),
    );
  }

  Padding Botones(BuildContext context) {
    final PokemonProvider c = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            heroTag: 'Personaaal',
            child: Icon(
              Icons.catching_pokemon_sharp,
              color: Color.fromARGB(190, 207, 207, 207),
            ),
            backgroundColor: Colors.black87,
            onPressed: () {
              Get.toNamed('personal');
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.delete),
            onPressed: () => c.clearTeam(),
          ),
        ],
      ),
    );
  }
}
