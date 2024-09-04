import 'package:flutter/material.dart';
import 'package:great_places/provider/great_places.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:great_places/screens/place_form_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp()); // Inicia a aplicação
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Cria um provider para gerenciar a instância de GreatPlaces
      create: (ctx) => GreatPlaces(), // Cria uma nova instância de GreatPlaces
      child: MaterialApp(
        // Cria a aplicação MaterialApp
        debugShowCheckedModeBanner: false, // Desabilita o banner de debug
        title: 'Great Places', // Define o título da aplicação
        theme: ThemeData(
          // Define o tema da aplicação
          colorScheme: ColorScheme.fromSeed(
              // Define as cores do tema
              seedColor: Colors.deepPurple, // Cor principal do tema
              primary: Colors.indigo, // Cor primária do tema
              secondary: Colors.amber), // Cor secundária do tema
          useMaterial3: true, // Usa o Material Design 3
        ),
        home: const PlacesListScreen(), // Define a tela inicial da aplicação
        routes: {
          // Define as rotas da aplicação
          AppRoutes.place_form: (ctx) =>
              const PlaceFormScreen(), // Rota para a tela de formulário
          AppRoutes.place_detail: (ctx) =>
              const PlaceDetailScreen(), // Rota para a tela de detalhes
        },
      ),
    );
  }
}
