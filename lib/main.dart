import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies/data/repositories/movies_repository.dart';
import 'package:movies/data/services/movies_service.dart';
import 'package:movies/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:movies/presentation/blocs/search_movies/search_movies_bloc.dart';
import 'package:movies/presentation/views/home.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final MoviesRepository moviesRepository;
  late final MoviesService moviesService;
  late final TMDB tmdb;


  @override
  void initState() {
    super.initState();
    tmdb = TMDB(
      ApiKeys(
        dotenv.env['TMDB_API_KEY']!,
        dotenv.env['TMDB_ACCESS_TOKEN']!
      ),
    );
    moviesService = MoviesService(tmdb);
    moviesRepository = MoviesRepository(moviesService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovieDetailsBloc(moviesRepository)),
        BlocProvider(create: (_) => SearchMoviesBloc(moviesRepository))
      ],
      child: MaterialApp(
        title: 'Movies',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomePage(),
      ),
    );
  }
}
