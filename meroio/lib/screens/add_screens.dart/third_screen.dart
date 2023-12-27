import 'package:flutter/material.dart';
import 'package:meroio/widgets/widgets.dart';

class AddThirdScreen extends StatefulWidget {
  const AddThirdScreen({super.key});
  static const routeName = '/add_third';

  @override
  State<AddThirdScreen> createState() => _AddThirdScreenState();
}

class _AddThirdScreenState extends State<AddThirdScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  TextEditingController fullDescriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(index: 2),
      body: Padding(
        padding: const EdgeInsets.only(top: 76.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Третье окно регистрации'),
          ElevatedButton(
            onPressed: () {
              // Логика для кнопки "Офлайн"
            },
            child: Text('Отправить'),
          )
        ]),
      ),
    );
  }
}
