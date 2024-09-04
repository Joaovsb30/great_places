import 'package:flutter/material.dart';
import 'package:great_places/provider/great_places.dart';
import 'package:provider/provider.dart';
import '../utils/app_routes.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Cria um Scaffold para a tela
      appBar: AppBar(
        // Cria uma AppBar para a tela
        title: const Text('Meus Lugares'), // Define o título da AppBar
        actions: [
          // Define as ações da AppBar
          IconButton(
            // Cria um botão na AppBar
            icon: const Icon(Icons.add), // Define o ícone do botão
            onPressed: () {
              // Define a ação do botão
              Navigator.of(context).pushNamed(
                // Navega para a tela de formulário
                AppRoutes.place_form, // Define a rota para a tela de formulário
              );
            },
          )
        ],
      ),
      body: FutureBuilder(
        // Cria um FutureBuilder para carregar os locais
        future: Provider.of<GreatPlaces>(context, listen: false)
            .loadPlaces(), // Carrega os locais do provider
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState
                    .waiting // Verifica se os locais ainda estão sendo carregados
            ? const Center(
                child:
                    CircularProgressIndicator()) // Se os locais ainda estão sendo carregados, exibe um indicador de progresso
            : Consumer<GreatPlaces>(
                // Se os locais já foram carregados, usa um Consumer para atualizar a tela quando os dados do provider mudarem
                builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount ==
                        0 // Verifica se a lista de locais está vazia
                    ? const Center(
                        child: Text(
                            'Nenhum local cadastrado')) // Se a lista de locais estiver vazia, exibe uma mensagem
                    : ListView.builder(
                        // Se a lista de locais não estiver vazia, exibe uma lista de locais
                        itemCount: greatPlaces
                            .itemsCount, // Define o número de itens da lista
                        itemBuilder: (ctx, i) => Card(
                          // Cria um cartão para cada local
                          elevation: 1, // Define a elevação do cartão
                          color: Theme.of(context)
                              .colorScheme
                              .secondary, // Define a cor do cartão
                          child: ListTile(
                            // Cria um ListTile para cada local
                            leading: CircleAvatar(
                              // Cria um CircleAvatar para a imagem do local
                              backgroundImage: FileImage(greatPlaces
                                  .itemByIndex(i)
                                  .image), // Define a imagem do CircleAvatar
                            ),
                            title: Text(greatPlaces
                                .itemByIndex(i)
                                .title), // Define o título do ListTile
                            subtitle: Text(greatPlaces
                                .itemByIndex(i)
                                .location
                                .address!), // Define a descrição do ListTile
                            onTap: () {
                              // Define a ação ao tocar no ListTile
                              Navigator.of(context).pushNamed(
                                // Navega para a tela de detalhes do local
                                AppRoutes
                                    .place_detail, // Define a rota para a tela de detalhes
                                arguments: greatPlaces.itemByIndex(
                                    i), // Passa o local como argumento
                              );
                            },
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
