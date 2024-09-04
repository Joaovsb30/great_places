import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {
  /// A localização inicial do mapa.
  final PlaceLocation initialLocation;

  /// Se o mapa é somente leitura.
  final bool isReadOnly;

  /// Construtor da classe MapScreen.
  const MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: -16.687011, // Latitude inicial do mapa (padrão: Brasília)
      longitude: -49.206928, // Longitude inicial do mapa (padrão: Brasília)
    ),
    this.isReadOnly = false, // Se o mapa é somente leitura (padrão: false)
    super.key,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  /// A localização selecionada no mapa.
  LatLng? _pickedPosition;

  /// Define a localização selecionada no mapa.
  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position; // Atualiza a localização selecionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Cria um Scaffold para a tela
      appBar: AppBar(
        // Cria uma AppBar para a tela
        title: const Text('Selecione...'), // Define o título da AppBar
        actions: [
          // Define as ações da AppBar
          if (!widget.isReadOnly) // Se o mapa não é somente leitura
            IconButton(
                // Cria um botão para confirmar a seleção
                onPressed: _pickedPosition ==
                        null // Se nenhuma posição foi selecionada, o botão está desabilitado
                    ? null
                    : () {
                        // Se uma posição foi selecionada, o botão confirma a seleção
                        Navigator.of(context).pop(
                            _pickedPosition); // Retorna a posição selecionada para a tela anterior
                      },
                icon: const Icon(Icons.check)) // Define o ícone do botão
        ],
      ),
      body: GoogleMap(
        // Cria o widget GoogleMap
        initialCameraPosition: CameraPosition(
          // Define a posição inicial da câmera
          target: LatLng(
            // Define a localização inicial da câmera
            widget.initialLocation.latitude, // Latitude da localização inicial
            widget
                .initialLocation.longitude, // Longitude da localização inicial
          ),
          zoom: 13, // Define o zoom inicial do mapa
        ),
        onTap: widget.isReadOnly
            ? null
            : _selectPosition, // Define a ação quando o usuário toca no mapa
        markers: (_pickedPosition == null &&
                !widget
                    .isReadOnly) // Se nenhuma posição foi selecionada e o mapa não é somente leitura
            ? {} // Não exibe nenhum marcador
            : {
                // Exibe um marcador
                Marker(
                  // Define o marcador
                  markerId: const MarkerId('p1'), // Define o ID do marcador
                  position: _pickedPosition ??
                      widget.initialLocation
                          .toLatLng(), // Define a posição do marcador
                )
              },
      ),
    );
  }
}
