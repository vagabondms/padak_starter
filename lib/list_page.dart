import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'model/response/movies_response.dart';
import 'model/data/dummys_repository.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, index) => const Divider(color: Colors.grey),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return ListWidget(index: index);
      },
    );
  }
}

Widget _buildGradeImage(int grade) {
  switch (grade) {
    case 0:
      return Image.asset("assets/ic_allages.png");
    case 12:
      return Image.asset("assets/ic_12.png");
    case 15:
      return Image.asset("assets/ic_15.png");
    case 19:
      return Image.asset("assets/ic_19.png");
    default:
      return Image.asset("assets/ic_allages.png");
  }
}

class ListWidget extends StatelessWidget {
  final int index;

  const ListWidget({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    return InkWell(
      child: ListItemWidget(movie: movies[index]),
      onTap: () {
        Navigator.of(buildContext).push(
          MaterialPageRoute(
            builder: (_) => DetailPage(
                movieId: movies[index].id, key: Key(movies[index].id)),
          ),
        );
      },
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final Movie movie;

  const ListItemWidget({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    return Container(
        padding: const EdgeInsets.all(12.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                movie.thumb,
                height: 120,
                width: 90,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              movie.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            _buildGradeImage(movie.grade),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(children: <Widget>[
                          Text('평점 : ${movie.userRating}'),
                          const SizedBox(width: 10),
                          Text('예매순위 : ${movie.reservationGrade}'),
                          const SizedBox(width: 10),
                          Text('예매율 : ${movie.reservationRate}'),
                        ]),
                        const SizedBox(height: 10),
                        Text('개봉일 : ${movie.date}'),
                      ]))
            ]));
  }
}

final List<Movie> movies = DummysRepository.loadDummyMovies();
