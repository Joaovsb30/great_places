import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Classe que representa a localização de um lugar.
class PlaceLocation {
  /// A latitude do lugar.
  final double latitude; // Latitude do local

  /// A longitude do lugar.
  final double longitude; // Longitude do local

  /// O endereço do lugar.
  final String? address; // Endereço do local

  /// Construtor da classe PlaceLocation.
  const PlaceLocation({
    required this.latitude, // Latitude do local (obrigatório)
    required this.longitude, // Longitude do local (obrigatório)
    this.address, // Endereço do local (opcional)
  });

  /// Converte a localização para um objeto LatLng do Google Maps.
  ///
  /// Retorna: Um objeto LatLng do Google Maps.
  LatLng toLatLng() {
    return LatLng(latitude, longitude); // Retorna a localização como LatLng
  }
}

/// Classe que representa um lugar.
class Place {
  /// O ID único do lugar.
  final String id; // ID único do local

  /// O título do lugar.
  final String title; // Título do local

  /// A localização do lugar.
  final PlaceLocation location; // Localização do local

  /// A imagem do lugar.
  final File image; // Imagem do local

  /// Construtor da classe Place.
  Place({
    required this.id, // ID único do local (obrigatório)
    required this.title, // Título do local (obrigatório)
    required this.image, // Imagem do local (obrigatório)
    required this.location, // Localização do local (obrigatório)
  });
}
