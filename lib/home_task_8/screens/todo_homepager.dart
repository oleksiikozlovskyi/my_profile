import 'package:flutter/material.dart';

class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({super.key});

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  final List<TaskItem> _tasks = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  final Duration _duration = Duration(milliseconds: 300);

  void _addTask() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final task = TaskItem(text: text);
    _tasks.insert(0, task);
    _listKey.currentState!.insertItem(0);

    _controller.clear();
    setState(() {});
  }

  void _removeTask(int index) {
    final removeTask = _tasks[index];

    _listKey.currentState!.removeItem(
      index,
          (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: FadeTransition(
          opacity: animation,
          child: _buildTaskTile(removeTask, index, removing: true),
        ),
      ),
      duration: _duration,
    );
  }

  Widget _buildTaskTile(TaskItem task, int index, {bool removing = false}) {
    return AnimatedOpacity(
      opacity: task.completed ? 0.5 : 1,
      duration: _duration,
      child: ListTile(
        leading: AnimatedSwitcher(
          duration: _duration,
          child: Checkbox(
            value: task.completed,
            key: ValueKey(task.completed),
            onChanged: (v) {
              setState(() {
                task.completed = v!;
              });
            },
          ),
        ),
        title: AnimatedDefaultTextStyle(
            style: TextStyle(
              fontSize: 18,
              decoration: task.completed ? TextDecoration.lineThrough : null,
              color: task.completed ? Colors.grey : Colors.black,
            ),
            duration: _duration,
            child: Text(task.text)),
        trailing: removing
            ? null
            : IconButton(
          onPressed: () => _removeTask(index),
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canAdd = _controller.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: (v) => setState(() {}),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter a task",
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: canAdd ? _addTask : null,
                  child: const Text("Add"),
                )
              ],
            ),
          ),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _tasks.length,
              itemBuilder: (context, index, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: _buildTaskTile(_tasks[index], index),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TaskItem {
  String text;
  bool completed;

  TaskItem({
    required this.text,
    this.completed = false,
  });
}
