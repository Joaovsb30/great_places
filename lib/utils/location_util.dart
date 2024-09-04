import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/utils/google_api_key.dart';
import 'package:http/http.dart' as http;

const googleApiKey = GoogleApiKey.key; // Define a chave da API do Google Maps

class LocationUtil {
  /// Gera a URL para uma imagem de pré-visualização estática do Google Maps.
  ///
  /// Parâmetros:
  ///  - latitute: A latitude da localização.
  ///  - longitude: A longitude da localização.
  ///
  /// Retorna: A URL da imagem de pré-visualização.
  static String generateLocationPreviewImage({
    double? latitute,
    double? longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?'
        'center=$latitute,$longitude&' // Define o centro do mapa
        'zoom=13&' // Define o nível de zoom
        'size=600x300&' // Define o tamanho da imagem
        'maptype=roadmap&' // Define o tipo de mapa
        'markers=color:red%7Alabel:C%7C$latitute,$longitude&' // Define o marcador no mapa
        'key=$googleApiKey'; // Define a chave da API
  }

  /// Obtém o endereço a partir de uma coordenada LatLng.
  ///
  /// Parâmetros:
  ///  - position: A coordenada LatLng.
  ///
  /// Retorna: O endereço formatado.
  static Future<String> getAddressFrom(LatLng position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey'; // Define a URL da API do Google Maps
    final response =
        await http.get(Uri.parse(url)); // Realiza a requisição HTTP
    return json.decode(response.body)['results'][0][
        'formatted_address']; // Decodifica o JSON e retorna o endereço formatado
  }
}
