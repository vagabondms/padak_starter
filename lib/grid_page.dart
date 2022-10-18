import 'package:flutter/material.dart';
import 'package:padak_starter/model/data/dummys_repository.dart';

import 'detail_page.dart';
import 'model/response/movies_response.dart';
// 1-3. Grid 리스트 화면 (임포트)

class GridPage extends StatelessWidget {
  // 1-4. Grid 리스트 화면 (동적 데이터 추가)

  @override
  Widget build(BuildContext context) {
    // 1-4. Grid 리스트 화면 (GridView 구축)
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (9 / 16),
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) => GridItemWidget(movie: movies[index]),
    );
  }
}

final List<Movie> movies = DummysRepository.loadDummyMovies();

class GridItemImageWidget extends StatelessWidget {
  final int grade;

  const GridItemImageWidget({
    required this.grade,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
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
}

class GridItemWidget extends StatelessWidget {
  final Movie movie;

  const GridItemWidget({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Image.network(
                    movie.thumb,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: GridItemImageWidget(grade: movie.grade))
                ],
              ),
            ),
            const SizedBox(height: 8),
            FittedBox(
              child: Text(
                movie.title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Text(
                '${movie.reservationGrade}위(${movie.userRating} / ${movie.reservationRate}%)'),
            const SizedBox(height: 8),
            Text(movie.date),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(buildContext).push(
          MaterialPageRoute(
            builder: (_) => DetailPage(movieId: movie.id, key: Key(movie.id)),
          ),
        );
      },
    );
  }
}
