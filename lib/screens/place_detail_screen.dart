import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém o objeto Place passado como argumento da rota
    Place place = ModalRoute.of(context)!.settings.arguments as Place;

    return Scaffold(
      // Cria um Scaffold para a tela
      appBar: AppBar(
        // Cria uma AppBar para a tela
        title: Text(place.title), // Define o título da AppBar
      ),
      body: Column(
        // Cria uma coluna para os widgets da tela
        children: [
          // Define os widgets da coluna
          SizedBox(
            // Cria um SizedBox para a imagem do local
            height: 250, // Define a altura do SizedBox
            width: double.infinity, // Define a largura do SizedBox
            child: Image.file(
              // Exibe a imagem do local
              place.image, // Define a imagem a ser exibida
              fit: BoxFit.cover, // Define o modo de ajuste da imagem
              width: double.infinity, // Define a largura da imagem
            ),
          ),
          const SizedBox(
            height: 10, // Define a altura do SizedBox
          ),
          Text(
            place.location.address!, // Exibe o endereço do local
            textAlign: TextAlign.center, // Define o alinhamento do texto
            style: const TextStyle(
              fontSize: 20, // Define o tamanho da fonte
              color: Colors.grey, // Define a cor do texto
            ),
          ),
          const SizedBox(
            height: 10, // Define a altura do SizedBox
          ),
          ElevatedButton.icon(
            // Cria um botão com ícone para exibir o local no mapa
            onPressed: () {
              // Define a ação ao pressionar o botão
              Navigator.of(context).push(
                // Navega para a tela do mapa
                MaterialPageRoute(
                  fullscreenDialog:
                      true, // Define a tela do mapa como um diálogo em tela cheia
                  builder: (context) => MapScreen(
                    // Define o widget a ser exibido na tela do mapa
                    isReadOnly:
                        true, // Define a tela do mapa como somente leitura
                    initialLocation:
                        place.location, // Define a localização inicial do mapa
                  ),
                ),
              );
            },
            icon: const Icon(Icons.map), // Define o ícone do botão
            label: Text(
              'Ver no mapa', // Define o rótulo do botão
              style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .primary), // Define o estilo do rótulo do botão
            ),
          ),
        ],
      ),
    );
  }
}
