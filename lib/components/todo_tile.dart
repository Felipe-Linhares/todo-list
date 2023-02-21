import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskComplete;
  final Function(bool?)? onChanged;
  final Function() deleteFunction;
  final Function() copyFunction;

  const ToDoTile(
      {super.key,
      required this.taskName,
      required this.taskComplete,
      required this.onChanged,
      required this.deleteFunction,
      required this.copyFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Checkbox(
                    value: taskComplete,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: onChanged,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      taskName,
                      style: TextStyle(
                          decoration: taskComplete
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: GestureDetector(
                onTap: copyFunction,
                child: const Icon(
                  Icons.copy,
                  color: Colors.teal,
                ),
              ),
            ),
            GestureDetector(
              onTap: deleteFunction,
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
