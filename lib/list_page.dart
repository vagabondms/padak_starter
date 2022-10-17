import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, index) => const Divider(color: Colors.grey),
      itemCount: 8,
      itemBuilder: (context, index) {
        print(index);
        return _buildDummyItem(
            img:
                'https://upload.wikimedia.org/wikipedia/ko/b/bc/%EB%B0%B1%EB%91%90%EC%82%B0_%EC%98%81%ED%99%94_%ED%8F%AC%EC%8A%A4%ED%84%B0.jpg',
            title: '신과함께',
            grade: 12,
            rating: 11,
            ticketRank: 11,
            ticketRatio: 11.3,
            openDate: DateTime.now());
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

Widget _buildDummyItem(
    {required String img,
    required String title,
    required int grade,
    required int rating,
    required int ticketRank,
    required double ticketRatio,
    required DateTime openDate}) {
  return Container(
      padding: const EdgeInsets.all(12.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              img,
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
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildGradeImage(grade),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(children: <Widget>[
                        Text('평점 : $rating'),
                        const SizedBox(width: 10),
                        Text('예매순위 : $ticketRank'),
                        const SizedBox(width: 10),
                        Text('예매율 : $ticketRatio'),
                      ]),
                      const SizedBox(height: 10),
                      Text('개봉일 : $openDate'),
                    ]))
          ]));
}



// 1-3. 리스트 화면 (고정 더미 데이터)

// 1-3. 리스트 화면 (동적 데이터 호출1)

// 1-3. 리스트 화면 (관람 등급 이미지 버튼 함수 생성)