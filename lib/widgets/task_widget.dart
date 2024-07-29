import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final String task;
  final bool isDone;
  final String description;
  final String assignedDate;
  final VoidCallback onToggle;
  final Function(String) onUpdateDescription;
  final VoidCallback onDelete;
  final VoidCallback onEditDescription;

  const TaskWidget({
    super.key,
    required this.task,
    required this.isDone,
    required this.description,
    required this.assignedDate,
    required this.onToggle,
    required this.onUpdateDescription,
    required this.onDelete,
    required this.onEditDescription,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task,
        style: TextStyle(
          decoration: isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description),
          Text(assignedDate),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
                isDone ? Icons.check_circle : Icons.radio_button_unchecked),
            onPressed: onToggle,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
      onTap: onEditDescription, // 설명 추가 다이얼로그 호출
    );
  }
}
