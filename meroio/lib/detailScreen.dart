import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meroio/screens/add_screens.dart/second_screen.dart';
import 'package:meroio/screens/answer_screen.dart';

class DetailedEventScreen extends StatefulWidget {
  final String title;

  const DetailedEventScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _DetailedEventScreenState createState() => _DetailedEventScreenState();
}

class _DetailedEventScreenState extends State<DetailedEventScreen> {
  late Future<Map<String, dynamic>> eventData;

  @override
  void initState() {
    super.initState();
    // Используйте widget.title, чтобы получить уникальный ID мероприятия
    eventData = fetchEventData(widget.title);
  }

  Future<Map<String, dynamic>> fetchEventData(String title) async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection(email)
              .doc(email)
              .collection('Созданные Меро')
              .doc(title)
              .collection('Информация о мероприятии')
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Если есть документы, используйте первый
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            querySnapshot.docs.first;
        return snapshot.data() ?? {};
      } else {
        print('Document does not exist for title: $title');
        return {}; // Return an empty map if the document does not exist
      }
    } catch (e) {
      print('Error fetching event data: $e');
      return {}; // Return an empty map in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Информация о мероприятии'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: eventData,
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              Map<String, dynamic> eventDetails = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Название:',
                        style: TextStyle(
                          color: Colors.black, // Set the text color
                          fontSize: 20.0, // Set the font size
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as needed
                        border: Border.all(
                          color: Colors.black, // Set the border color
                          width: 2.0, // Set the border width
                        ), // Set the background color
                      ),
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 7, bottom: 7),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${eventDetails['title']}',
                              style: TextStyle(
                                color: Colors.black, // Set the text color
                                fontSize: 20.0, // Set the font size
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Add logic to handle the edit button press
                              // For example, show a dialog for editing the title
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Редактировать название"),
                                    content: TextField(
                                      controller: TextEditingController(
                                          text: eventDetails['title']),
                                      onChanged: (newTitle) {
                                        // Update the title in real-time
                                        setState(() {
                                          eventDetails['title'] = newTitle;
                                        });
                                      },
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Закрыть"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          // Add logic to update the title in Firestore
                                          try {
                                            String email = FirebaseAuth
                                                .instance.currentUser!.email!;
                                            String eventTitle =
                                                eventDetails['title'];

                                            await FirebaseFirestore.instance
                                                .collection(email)
                                                .doc(email)
                                                .collection('Созданные Меро')
                                                .doc(eventTitle)
                                                .update({
                                              'title': eventDetails['title']
                                            });

                                            Navigator.pop(
                                                context); // Close the dialog
                                          } catch (e) {
                                            print(
                                                'Ошибка в обновлении названия: $e');
                                            // Handle the error as needed
                                          }
                                        },
                                        child: Text("Сохранить"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Add logic to handle the delete button press
                              // For example, show a confirmation dialog before deleting
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        "Удалить ${eventDetails['title']}?"),
                                    content: Text(
                                        "Вы уверены что хотите удалить мероприятие: ${eventDetails['title']} навсегда?"),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Закрыть"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add logic to delete the Firestore document
                                          // For example:
                                          // deleteFirestoreDocument(eventDetails['title']);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Удалить"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    //_____________________________________________________
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Описание:',
                        style: TextStyle(
                          color: Colors.black, // Set the text color
                          fontSize: 20.0, // Set the font size
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as needed
                        border: Border.all(
                          color: Colors.black, // Set the border color
                          width: 2.0, // Set the border width
                        ), // Set the background color
                      ),
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 7, bottom: 7),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${eventDetails['shortDesc']}',
                              style: TextStyle(
                                color: Colors.black, // Set the text color
                                fontSize: 20.0, // Set the font size
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Add logic to handle the edit button press
                              // For example, show a dialog for editing the short description
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Редактировать описание"),
                                    content: TextField(
                                      controller: TextEditingController(
                                          text: eventDetails['shortDesc']),
                                      onChanged: (newShortDesc) {
                                        // Update the short description in real-time
                                        setState(() {
                                          eventDetails['shortDesc'] =
                                              newShortDesc;
                                        });
                                      },
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Закрыть"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          try {
                                            // Add logic to update the short description in Firestore
                                            String email = FirebaseAuth
                                                .instance.currentUser!.email!;
                                            String eventTitle =
                                                eventDetails['title'];

                                            await FirebaseFirestore.instance
                                                .collection(email)
                                                .doc(email)
                                                .collection('Созданные Меро')
                                                .doc(eventTitle)
                                                .update({
                                              'shortDesc':
                                                  eventDetails['shortDesc']
                                            });

                                            Navigator.pop(
                                                context); // Close the dialog after a successful update
                                          } catch (e) {
                                            print(
                                                'Ошибка при обновлении данных: $e');
                                            // Handle the error as needed
                                          }
                                        },
                                        child: Text("Сохранить"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    //_____________________________________________
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Полное описание:',
                        style: TextStyle(
                          color: Colors.black, // Set the text color
                          fontSize: 20.0, // Set the font size
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as needed
                        border: Border.all(
                          color: Colors.black, // Set the border color
                          width: 2.0, // Set the border width
                        ), // Set the background color
                      ),
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 7, bottom: 7),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${eventDetails['fullDesc']}',
                              style: TextStyle(
                                color: Colors.black, // Set the text color
                                fontSize: 20.0, // Set the font size
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Add logic to handle the edit button press
                              // For example, show a dialog for editing the title
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        Text("Редактировать полное описание"),
                                    content: TextField(
                                      controller: TextEditingController(
                                          text: eventDetails['fullDesc']),
                                      onChanged: (newFullDesc) {
                                        // Update the title in real-time
                                        setState(() {
                                          eventDetails['fullDesc'] =
                                              newFullDesc;
                                        });
                                      },
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Закрыть"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          try {
                                            String email = FirebaseAuth
                                                .instance.currentUser!.email!;
                                            String eventTitle =
                                                eventDetails['title'];

                                            // Retrieve the document reference based on the title
                                            DocumentReference eventDocRef =
                                                FirebaseFirestore.instance
                                                    .collection(email)
                                                    .doc(email)
                                                    .collection(
                                                        'Созданные Меро')
                                                    .doc(eventTitle)
                                                    .collection(
                                                        'Информация о мероприятии')
                                                    .doc(); // This creates a new document reference with a unique ID

                                            // Get the dynamically generated document ID

                                            // Update the 'fullDesc' field with the value of 'fullDesc'
                                            await eventDocRef.update({
                                              'fullDesc':
                                                  eventDetails['fullDesc'],
                                            });

                                            Navigator.pop(
                                                context); // Close the dialog after a successful update
                                          } catch (e) {
                                            print(
                                                'Ошибка при обновлении данных: $e');
                                            // Handle the error as needed
                                          }
                                        },
                                        child: Text("Сохранить"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    //__________________________________
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        'Адрес:',
                        style: TextStyle(
                          color: Colors.black, // Set the text color
                          fontSize: 20.0, // Set the font size
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as needed
                        border: Border.all(
                          color: Colors.black, // Set the border color
                          width: 2.0, // Set the border width
                        ), // Set the background color
                      ),
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 7, bottom: 7),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${eventDetails['location']}',
                              style: TextStyle(
                                color: Colors.black, // Set the text color
                                fontSize: 20.0, // Set the font size
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Add logic to handle the edit button press
                              // For example, show a dialog for editing the title
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Редактировать адрес"),
                                    content: TextField(
                                      controller: TextEditingController(
                                          text: eventDetails['location']),
                                      onChanged: (newLocation) {
                                        // Update the title in real-time
                                        setState(() {
                                          eventDetails['location'] =
                                              newLocation;
                                        });
                                      },
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Закрыть"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add logic to update the Firestore document with the new title
                                          // For example:
                                          // updateFirestoreTitle(eventDetails['title']);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Сохранить"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () async {
                        String email =
                            FirebaseAuth.instance.currentUser!.email!;
                        String eventTitle = eventDetails['title'];
                        // Add logic to fetch event details and pass them to AnswerScreen
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => AnswerScreen(),
                        //   ),
                        // );
                      },
                      child: Text('Перейти на AnswerScreen'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
