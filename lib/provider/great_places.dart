import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/utils/bd_util.dart';
import 'package:great_places/utils/location_util.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  /// Lista de locais.
  List<Place> _items = []; // Lista privada para armazenar os locais

  /// Carrega os locais do banco de dados.
  ///
  /// Recupera todos os locais do banco de dados e atualiza a lista de locais.
  Future<void> loadPlaces() async {
    final dataList =
        await DbUtil.getData('places'); // Recupera os locais do banco de dados

    _items =
        dataList // Converte a lista de mapas do banco de dados para uma lista de objetos Place
            .map((item) => Place(
                  id: item['id'], // Define o ID do local
                  title: item['title'], // Define o título do local
                  image: File(item['image']), // Define a imagem do local
                  location: PlaceLocation(
                    latitude: item['lat'], // Define a latitude do local
                    longitude: item['lng'], // Define a longitude do local
                    address: item['address'], // Define o endereço do local
                  ),
                ))
            .toList(); // Converte o iterable para uma lista

    notifyListeners(); // Notifica os listeners que os dados foram atualizados
  }

  /// Retorna a lista de locais.
  List<Place> get items {
    return [..._items]; // Retorna uma cópia da lista de locais
  }

  /// Retorna o número de locais.
  int get itemsCount {
    return _items.length; // Retorna o tamanho da lista de locais
  }

  /// Retorna um local específico da lista pelo índice.
  Place itemByIndex(int index) {
    return _items[index]; // Retorna o local na posição especificada
  }

  /// Adiciona um novo local à lista.
  ///
  /// Parâmetros:
  ///  - title: O título do local.
  ///  - image: A imagem do local.
  ///  - position: A localização do local.
  Future<void> addPlaces({
    required String title, // Título do local (obrigatório)
    required File image, // Imagem do local (obrigatório)
    required LatLng position, // Localização do local (obrigatório)
  }) async {
    String address = await LocationUtil.getAddressFrom(
        position); // Obtem o endereço da localização

    final newPlace = Place(
        // Cria um novo objeto Place
        id: Random().nextDouble().toString(), // Gera um ID aleatório
        title: title, // Define o título do local
        image: image, // Define a imagem do local
        location: PlaceLocation(
            // Define a localização do local
            latitude: position.latitude, // Latitude do local
            longitude: position.longitude, // Longitude do local
            address: address // Endereço do local
            ));

    _items.add(newPlace); // Adiciona o novo local à lista
    DbUtil.insert('places', {
      // Insere o novo local no banco de dados
      'id': newPlace.id, // Define o ID do local no banco de dados
      'title': newPlace.title, // Define o título do local no banco de dados
      'image': newPlace
          .image.path, // Define o caminho da imagem do local no banco de dados
      'lat': position.latitude, // Define a latitude do local no banco de dados
      'lng':
          position.longitude, // Define a longitude do local no banco de dados
      'address': address, // Define o endereço do local no banco de dados
    });
    notifyListeners(); // Notifica os listeners que os dados foram atualizados
  }
}
