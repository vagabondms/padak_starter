import "package:flutter/material.dart";
import 'list_page.dart';
import 'grid_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie'), actions: <Widget>[
        PopupMenuButton<int>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              if (value == 0) {
                print('예매율순');
              } else if (value == 1) {
                print('gkdl');
              } else {
                print('최신순');
              }
            },
            itemBuilder: (context) => [
                  const PopupMenuItem(value: 0, child: Text("예매율순")),
                  const PopupMenuItem(value: 1, child: Text("큐레이션")),
                  const PopupMenuItem(value: 2, child: Text("최신순")),
                ])
      ]),
      body: BuildPageWidget(index: _selectedTabIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.view_list), label: 'List'),
            BottomNavigationBarItem(icon: Icon(Icons.view_list), label: 'Grid')
          ],
          currentIndex: _selectedTabIndex,
          onTap: (index) {
            setState(() {
              _selectedTabIndex = index;
            });
          }),
    );
  }
}

//Widget으로 만들 필요가 있나??
class BuildPageWidget extends StatelessWidget {
  final int index;

  const BuildPageWidget({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return ListPage();
    } else {
      return GridPage();
    }
  }
}
