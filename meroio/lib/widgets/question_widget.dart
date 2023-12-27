import 'package:flutter/material.dart';
import 'package:meroio/screens/add_screens.dart/second_screen.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final VoidCallback onDelete;

  QuestionWidget({required this.question, required this.onDelete});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            widget.question.titleSec = value;
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                widget.onDelete();
              },
            ),
            border: OutlineInputBorder(),
            labelText: 'Название вопроса',
          ),
          controller: TextEditingController(text: widget.question.titleSec),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text('Обязателен к заполнению*:'),
            Checkbox(
              value: widget.question.isRequired,
              onChanged: (value) {
                setState(() {
                  widget.question.isRequired = value ?? false;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
