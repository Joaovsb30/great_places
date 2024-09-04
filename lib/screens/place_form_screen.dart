import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/provider/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController =
      TextEditingController(); // Controlador para o campo de texto do título

  File? _pickedImage; // Arquivo da imagem selecionada
  LatLng? _pickedLocation; // Localização selecionada

  /// Define a imagem selecionada.
  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage; // Atualiza a imagem selecionada
    });
  }

  /// Define a localização selecionada.
  void _selectPosition(LatLng position) {
    setState(() {
      _pickedLocation = position; // Atualiza a localização selecionada
    });
  }

  /// Verifica se o formulário é válido.
  bool _isValidForm() {
    return _titleController
            .text.isNotEmpty && // Verifica se o título não está vazio
        _pickedImage != null && // Verifica se uma imagem foi selecionada
        _pickedLocation != null; // Verifica se uma localização foi selecionada
  }

  /// Envia o formulário para o provider.
  void _submitForm() {
    if (!_isValidForm())
      return; // Verifica se o formulário é válido antes de enviar

    Provider.of<GreatPlaces>(context, listen: false).addPlaces(
      // Adiciona o novo local ao provider
      title: _titleController.text, // Título do local
      image: _pickedImage!, // Imagem do local
      position: _pickedLocation!, // Localização do local
    );

    Navigator.of(context).pop(); // Retorna para a tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Cria um Scaffold para a tela
      appBar: AppBar(
        // Cria uma AppBar para a tela
        title: const Text('Novo lugar'), // Define o título da AppBar
      ),
      body: Column(
        // Cria uma coluna para os widgets da tela
        crossAxisAlignment: CrossAxisAlignment
            .stretch, // Define o alinhamento dos widgets da coluna
        children: [
          // Define os widgets da coluna
          Expanded(
            // Expanda o primeiro widget para ocupar a maior parte da tela
            flex: 15, // Define o fator de expansão do widget
            child: SingleChildScrollView(
              // Permite rolagem do widget
              child: Padding(
                // Adiciona um padding ao widget
                padding:
                    const EdgeInsets.all(10.0), // Define o padding do widget
                child: Column(
                  // Cria uma coluna para os widgets do formulário
                  children: [
                    // Define os widgets do formulário
                    TextField(
                      // Campo de texto para o título
                      controller:
                          _titleController, // Controlador para o campo de texto
                      decoration: const InputDecoration(
                        labelText: 'Título', // Rótulo do campo de texto
                      ),
                      onChanged: (text) {
                        // Função chamada quando o texto do campo de texto é alterado
                        setState(() {}); // Redesenha a tela
                      },
                    ),
                    const SizedBox(
                      height:
                          10, // Espaço entre o campo de texto e o próximo widget
                    ),
                    ImageInput(_selectImage), // Widget para selecionar a imagem
                    const SizedBox(
                      height:
                          10, // Espaço entre o widget ImageInput e o próximo widget
                    ),
                    LocationInput(
                      onSelectPosition:
                          _selectPosition, // Widget para selecionar a localização
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            // Expanda o botão para ocupar o restante da tela
            child: ElevatedButton.icon(
              // Cria um botão com ícone
              label: const Text('Adicionar'), // Rótulo do botão
              onPressed: _isValidForm()
                  ? _submitForm
                  : null, // Função chamada quando o botão é pressionado
              icon: const Icon(Icons.add), // Ícone do botão
              style: ElevatedButton.styleFrom(
                // Define o estilo do botão
                foregroundColor: Theme.of(context)
                    .colorScheme
                    .primary, // Cor do texto do botão
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .secondary, // Cor de fundo do botão
                shape: const RoundedRectangleBorder(
                  // Define a forma do botão
                  borderRadius: BorderRadius.only(
                    // Define o raio da borda do botão
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                elevation: 0, // Define a elevação do botão
              ),
            ),
          ),
        ],
      ),
    );
  }
}
