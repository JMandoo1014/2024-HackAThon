import 'package:flutter/material.dart';
import 'todo_page.dart';
import 'calendar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planit'),
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'To-Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    if (_selectedIndex == 0) {
      return const TodoPage();
    } else {
      return const CalendarPage();
    }
  }
}

/*-----------------------------------------------------------------
-----------------------------------------------------------------------
----------------------------------------------------------------------
맨 아래쪽에 버튼 투두 페이지와 캘린더 페이지 이동 시 투두 데이터 날아가는
이슈 잇습니다ㅜㅜ*/
