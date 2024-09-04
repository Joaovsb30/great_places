import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function?
      onSelectPosition; // Função para chamar quando a posição for selecionada
  const LocationInput({this.onSelectPosition, super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl; // URL da imagem de pré-visualização da localização

  // Método para exibir a pré-visualização da localização
  _showPreview(double latitude, double longitude) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitute: latitude, // Latitude da localização
      longitude: longitude, // Longitude da localização
    );

    setState(() {
      _previewImageUrl =
          staticMapImageUrl; // Atualiza a URL da imagem de pré-visualização
    });
  }

  // Método para obter a localização atual do usuário
  Future<void> _getCurrentUserLocation() async {
    try {
      final locData =
          await Location().getLocation(); // Obtem a localização atual
      _showPreview(locData.latitude!,
          locData.longitude!); // Exibe a pré-visualização da localização
      widget.onSelectPosition!(
        // Chama a função onSelectPosition
        LatLng(
          locData.latitude!, // Latitude da localização atual
          locData.longitude!, // Longitude da localização atual
        ),
      );
    } catch (e) {
      return; // Se ocorrer um erro, não faz nada
    }
  }

  // Método para selecionar a localização no mapa
  Future<void> _selectOnMap() async {
    try {
      final LatLng selectedPosition = await Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true, // Exibe a tela do mapa em tela cheia
          builder: (ctx) => const MapScreen(), // Constrói a tela do mapa
        ),
      );
      _showPreview(
          selectedPosition.latitude,
          selectedPosition
              .longitude); // Exibe a pré-visualização da localização selecionada
      widget.onSelectPosition!(
          selectedPosition); // Chama a função onSelectPosition
    } catch (e) {
      return; // Se ocorrer um erro, não faz nada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // Container para exibir a pré-visualização da localização
          height: 170, // Altura do container
          width: double.infinity, // Largura do container
          alignment: Alignment.center, // Alinhamento do conteúdo do container
          decoration: BoxDecoration(
            // Decoração do container
            border: Border.all(
              width: 1, // Espessura da borda
              color: Colors.grey, // Cor da borda
            ),
          ),
          child: _previewImageUrl == null
              ? const Text(
                  'Nenhum local selecionado') // Se a imagem de pré-visualização não estiver disponível, exibe um texto
              : Image.network(
                  _previewImageUrl!, // Se a imagem de pré-visualização estiver disponível, exibe a imagem
                  fit: BoxFit.cover, // Ajusta a imagem para cobrir o container
                  width: double
                      .infinity, // Define a largura da imagem como a largura do container
                ),
        ),
        Row(
          // Row para exibir os botões de seleção de localização
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Alinhamento dos botões
          children: [
            TextButton.icon(
              // Botão para selecionar a localização atual
              onPressed:
                  _getCurrentUserLocation, // Função a ser chamada ao pressionar o botão
              icon: const Icon(Icons.location_on), // Ícone do botão
              label: Text(
                'Localização atual', // Rótulo do botão
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .primary, // Cor do texto do botão
                ),
              ),
            ),
            TextButton.icon(
              // Botão para selecionar a localização no mapa
              onPressed:
                  _selectOnMap, // Função a ser chamada ao pressionar o botão
              icon: const Icon(Icons.map), // Ícone do botão
              label: Text(
                'Selecionar no mapa', // Rótulo do botão
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .primary, // Cor do texto do botão
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
