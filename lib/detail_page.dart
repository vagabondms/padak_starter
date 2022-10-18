import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:padak_starter/comment_page.dart';
import 'package:padak_starter/model/data/dummys_repository.dart';

import 'model/response/comments_response.dart';
import 'model/response/movie_response.dart';

class DetailPage extends StatefulWidget {
  final String movieId;

  const DetailPage({
    required this.movieId,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _DetailState();
}

class _DetailState extends State<DetailPage> {
  String movieId = "";
  MovieResponse? _movieResponse;
  CommentsResponse? _commentsResponse;

  _DetailState();

  @override
  void initState() {
    super.initState();
    movieId = widget.movieId;
  }

  @override
  Widget build(BuildContext context) {
    // 2-1. 상세 화면 (테스트 데이터 설정 - 영화 상세)
    final movieResponse = DummysRepository.loadDummyMovie(movieId);
    final commentsResponse = DummysRepository.loadDummyComments(movieId);
    // 2-5. 상세 화면 (테스트 데이터 설정 - 댓글 상세)

    // 2-1. 상세 화면 (조건문에 따라 위젯 다르게 나오도록 하기) - 1
    return Scaffold(
        appBar: AppBar(
          // 2-1. 상세 화면 (제목 설정)
          title: Text(movieResponse.title),
        ),
        // 2-1. 상세 화면 (전체 화면 세팅1)
        body: DetailBodyWidget(
          movieResponse: movieResponse,
          commentsResponse: commentsResponse,
        ));
  }
}

// 2-1. 상세 화면 (전체 화면 세팅2)
class DetailBodyWidget extends StatelessWidget {
  final MovieResponse movieResponse;
  final CommentsResponse commentsResponse;

  const DetailBodyWidget({
    required this.movieResponse,
    required this.commentsResponse,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DetailMovieSummaryWidget(
          movieResponse: movieResponse,
        ),
        DetailMovieSynopsisWidget(
          movieResponse: movieResponse,
        ),
        DetailMovieCastWidget(
          movieResponse: movieResponse,
        ),
        DetailMovieCommentWidget(
          commentsResponse: commentsResponse,
          movieResponse: movieResponse,
        ),
      ],
    );
  }
}

class DetailMovieSummaryWidget extends StatelessWidget {
  // 2-2. Summary 화면 (데이터 추가)
  final MovieResponse movieResponse;

  const DetailMovieSummaryWidget({
    // 2-2. Summary 화면 (데이터 필수화 및 연결)
    required this.movieResponse,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2-2. Summary 화면 (화면 구현)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.network(movieResponse.image, height: 180),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(movieResponse.title),
                Text(movieResponse.date),
                Text('${movieResponse.genre} / ${movieResponse.duration}분')
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildReservationRate(movieResponse),
            buildVerticalDivider(),
            buildRating(movieResponse),
            buildVerticalDivider(),
            buildAccumulatedAudience(movieResponse)
          ],
        )
      ],
    );
  }
}

// 2-2. Summary 화면 (1-2 과정)

// 2-2. Summary 화면 (2-2 과정 - 예매율)
Widget buildReservationRate(MovieResponse movieResponse) {
  return Column(children: <Widget>[
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          '예매율',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
            '${movieResponse.reservationGrade}위 ${movieResponse.reservationRate.toString()}%')
      ],
    )
  ]);
}

// 2-2. Summary 화면 (2-2 과정 - 평점)
Widget buildRating(MovieResponse movieResponse) {
  return Column(children: <Widget>[
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text('평점',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 10),
        Text(movieResponse.userRating.toString())
      ],
    )
  ]);
}

// 2-2. Summary 화면 (2-2 과정 - 누적관객수)
Widget buildAccumulatedAudience(MovieResponse movieResponse) {
  return Column(children: <Widget>[
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          '누적 관객수',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(movieResponse.audience.toString())
      ],
    )
  ]);
}

// 2-2. Summary 화면 (2-2 과정 - 구분선)
Widget buildVerticalDivider() {
  return Container(width: 1, height: 50, color: Colors.grey);
}

class DetailMovieSynopsisWidget extends StatelessWidget {
  // 2-3. Synopsis 화면 (데이터 추가)
  final MovieResponse movieResponse;

  const DetailMovieSynopsisWidget({
    // 2-3. Synopsis 화면 (데이터 필수화 및 연결)
    required this.movieResponse,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2-3. Synopsis 화면 (화면 구현)
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 10,
            color: Colors.grey.shade400,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              '줄거리',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 16, top: 10, bottom: 5, right: 16),
            child: Text(movieResponse.synopsis),
          )
        ]);
  }
}

class DetailMovieCastWidget extends StatelessWidget {
  // 2-4. MovieCast 화면 (데이터 추가)
  final MovieResponse movieResponse;

  const DetailMovieCastWidget({
    // 2-4. MovieCast 화면 (데이터 필수화 및 연결)
    required this.movieResponse,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2-4. MovieCast 화면 (감독 / 출연 구현)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildDivider(),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            '감독/출연',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(
              left: 16,
              top: 10,
              bottom: 5,
              right: 16,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Text(
                      '감독',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text(movieResponse.director)
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    const Text(
                      '출연',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(movieResponse.actor),
                    )
                  ],
                )
              ],
            ))
      ],
    );
  }
}

Widget buildDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    width: double.infinity,
    height: 10,
    color: Colors.grey.shade400,
  );
}

class DetailMovieCommentWidget extends StatelessWidget {
  final CommentsResponse commentsResponse;
  final MovieResponse movieResponse;

  // 2-5. Comment 화면 (댓글 입력 창으로 이동을 위해 movieResponse 를 매개변수로 받도록 하기)

  const DetailMovieCommentWidget({
    required this.commentsResponse,
    required this.movieResponse,
    Key? key,
    // 2-5. Comment 화면 (댓글 입력 창으로 이동을 위해 movieResponse 값을 매치시키기)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2-5. Comment 화면 (화면 구현)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildDivider(),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                '한줄평',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.create),
                color: Colors.blue,
                onPressed: () =>
                    _presentCommentPage(context, movieResponse: movieResponse),
              )
            ],
          ),
        ),
        CommentListView(commentsResponse)
      ],
    );
  }
}

// 2-5. Comment 화면 (한줄평 리스트)
class CommentListView extends StatelessWidget {
  final CommentsResponse commentsResponse;

  const CommentListView(
    this.commentsResponse, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(10),
      itemCount: commentsResponse.comments.length,
      itemBuilder: (_, index) => CommentItem(commentsResponse.comments[index]),
    );
  }
}

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem(
    this.comment, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(
              Icons.person_pin,
              size: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(comment.writer),
                const SizedBox(width: 5),
                Text(
                  _convertTimeStampToDateTime(comment.timestamp),
                ),
                const SizedBox(height: 5),
                Text(comment.contents)
              ],
            ),
          ],
        ));
  }
}
// 2-5. Comment 화면 (한줄평 아이템 화면 구축)

// 2-5. Comment 화면 (포맷에 맞춰 날짜 데이터 반환)

String _convertTimeStampToDateTime(int timeStamp) {
  final dateFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  return dateFormatter.format(
    DateTime.fromMicrosecondsSinceEpoch(
      timeStamp * 1000,
    ),
  );
}

// 2-5. Comment 화면 (댓글 입력 창으로 이동)
void _presentCommentPage(
  BuildContext context, {
  required MovieResponse movieResponse,
}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => CommentPage(
          movieTitle: movieResponse.title, movieId: movieResponse.id),
    ),
  );
}
