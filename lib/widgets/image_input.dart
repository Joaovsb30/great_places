import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

/// Widget que permite ao usuário tirar uma foto e selecionar uma imagem.
class ImageInput extends StatefulWidget {
  /// Função a ser chamada quando uma imagem é selecionada.
  /// Recebe o caminho da imagem salva como argumento.
  final Function onSelectImage;

  /// Construtor da classe ImageInput.
  const ImageInput(this.onSelectImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  /// Armazena a imagem selecionada como um arquivo.
  File? _storedImage;

  /// Tira uma foto com a câmera do dispositivo e salva a imagem.
  Future<void> _takePicture() async {
    // Cria um objeto ImagePicker para escolher imagens.
    final ImagePicker _picker = ImagePicker();

    // Captura uma imagem da câmera.
    XFile imageFile = await _picker.pickImage(
      source: ImageSource.camera, // Define a fonte como a câmera
      maxWidth: 600, // Define a largura máxima da imagem
    ) as XFile;

    // Atualiza o estado para exibir a imagem selecionada.
    setState(() {
      _storedImage = File(imageFile.path); // Define a imagem selecionada
    });

    // Obtém o diretório de documentos do aplicativo.
    final appDir = await syspaths.getApplicationDocumentsDirectory();

    // Cria um nome de arquivo único para a imagem salva.
    String fileName =
        path.basename(_storedImage!.path); // Obtém o nome do arquivo da imagem

    // Copia a imagem para o diretório de documentos.
    final savedImage = await _storedImage!.copy(
        '${appDir.path}/$fileName'); // Copia a imagem para o diretório de documentos

    // Chama a função onSelectImage para notificar o widget pai sobre a imagem selecionada.
    widget.onSelectImage(savedImage); // Chama a função onSelectImage
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Container para exibir a imagem selecionada.
        Container(
          height: 100, // Altura do container
          width: 180, // Largura do container
          decoration: BoxDecoration(
            // Decoração do container
            border: Border.all(
              color: Colors.grey, // Cor da borda
              width: 1, // Espessura da borda
            ),
          ),
          alignment: Alignment.center, // Alinhamento do conteúdo do container
          child: _storedImage == null
              ? const Text(
                  'Nenhuma Imagem!') // Se a imagem não estiver disponível, exibe um texto
              : Image.file(
                  _storedImage!, // Se a imagem estiver disponível, exibe a imagem
                  fit: BoxFit.cover, // Ajusta a imagem para cobrir o container
                  width: double
                      .infinity, // Define a largura da imagem como a largura do container
                ),
        ),
        const SizedBox(
          width: 10, // Espaço entre o container da imagem e o botão
        ),
        // Botão para tirar uma foto.
        Expanded(
          // Expanda o botão para ocupar o espaço restante
          child: TextButton.icon(
            icon: const Icon(Icons.camera), // Ícone do botão
            label: const Text('Tirar foto'), // Rótulo do botão
            onPressed:
                _takePicture, // Chama o método _takePicture ao ser pressionado
          ),
        )
      ],
    );
  }
}
