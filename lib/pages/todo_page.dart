import 'package:flutter/material.dart';
import 'calendar_page.dart';
import '../widgets/task_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  TodoPageState createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  final List<Map<String, dynamic>> _todos = [];
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  void _addTodo() {
    if (_selectedDate != null && _descriptionController.text.isNotEmpty) {
      setState(() {
        _todos.add({
          'task': _descriptionController.text, // 설명을 할 일로 사용
          'isDone': false,
          'description': '',
          'assignedDate':
              '${_selectedDate!.year}년 ${_selectedDate!.month}월 ${_selectedDate!.day}일',
        });
        _descriptionController.clear(); // 입력 필드 비우기
        _selectedDate = null; // 추가 후 선택된 날짜 초기화
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('설명과 날짜를 선택해주세요.')),
      );
    }
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  Future<void> _showDescriptionDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('할 일 추가'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: '설명을 입력하세요'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                // 날짜 선택 다이얼로그 열기
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (selectedDate != null) {
                  setState(() {
                    _selectedDate = selectedDate;
                    _addTodo(); // 날짜가 선택되면 할 일 추가
                  });
                }
              },
              child: const Text('저장'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // + 버튼 추가
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _showDescriptionDialog(context), // 설명 입력 다이얼로그 열기
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(_todos[index]['task']),
                direction: DismissDirection.horizontal,
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  _deleteTodo(index);
                },
                child: TaskWidget(
                  task: _todos[index]['task'],
                  isDone: _todos[index]['isDone'],
                  description: _todos[index]['description'],
                  assignedDate: _todos[index]['assignedDate'],
                  onToggle: () {
                    setState(() {
                      _todos[index]['isDone'] = !_todos[index]['isDone'];
                    });
                  },
                  onEditDescription: () {
                    // 여기서 설명 편집 다이얼로그를 호출할 수 있습니다.
                  },
                  onUpdateDescription: (newDescription) {
                    setState(() {
                      _todos[index]['description'] = newDescription;
                    });
                  },
                  onDelete: () => _deleteTodo(index),
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            // 캘린더 페이지로 이동
            final selectedDate = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CalendarPage()),
            );
            if (selectedDate != null) {
              setState(() {
                _selectedDate = selectedDate; // 선택한 날짜를 저장
              });
            }
          },
          child: const Text('캘린더 보기'),
        ),
      ],
    );
  }
}
