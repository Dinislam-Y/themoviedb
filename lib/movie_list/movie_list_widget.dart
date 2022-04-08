import 'package:flutter/material.dart';
import 'package:themoviedb/resources/resources.dart';

class MovieList {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  MovieList({
    required this.id,
    required this.imageName,
    required this.title,
    required this.time,
    required this.description,
  });
}

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movie = [
    MovieList(
      id: 1,
      imageName: AppImages.mortal,
      title: 'Сметрельная битва',
      time: 'April 7, 2021',
      description: 'Mortal Kombat is back and better than ever in the next',
    ),
    MovieList(
      id: 2,
      imageName: AppImages.mortal,
      title: 'Тихие зори',
      time: 'April 7, 2021',
      description: 'Mortal Kombat is back and better than ever in the next',
    ),
    MovieList(
      id: 3,
      imageName: AppImages.mortal,
      title: 'Дюна',
      time: 'April 7, 2021',
      description: 'Mortal Kombat is back and better than ever in the next',
    ),
    MovieList(
      id: 4,
      imageName: AppImages.mortal,
      title: 'Симпсоны',
      time: 'April 7, 2021',
      description: 'Mortal Kombat is back and better than ever in the next',
    ),
  ];

  var _filteredMovies = <MovieList>[];

  final _searchController = TextEditingController();

  void _searchMovies() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movie.where((MovieList movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movie;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filteredMovies = _movie;
    _searchController.addListener(_searchMovies);
  }

  void _onMovieTap(int index) {
    final id = _movie[index].id;
    Navigator.of(context).pushNamed(
      '/main_screen/movie_details',
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(top: 70),
          itemCount: _filteredMovies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final movie = _filteredMovies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        Image(image: AssetImage(movie.imageName)),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                movie.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                movie.time,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                movie.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => _onMovieTap(index),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              fillColor: Colors.white.withAlpha(235),
              filled: true,
              border: const OutlineInputBorder(),
              labelText: 'Поиск',
            ),
          ),
        )
      ],
    );
  }
}
