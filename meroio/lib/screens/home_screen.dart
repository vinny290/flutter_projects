import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meroio/detailScreen.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});
  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User? user; // Use User? instead of User

  late List<String> eventTitles = [];

  @override
  void initState() {
    super.initState();
    _loadEventTitles();
  }

  Future<void> _loadEventTitles() async {
    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String email = user!.email!;

      try {
        QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection(email)
            .doc(email)
            .collection('Созданные Меро')
            .get();

        eventTitles = snapshot.docs.map((doc) => doc.id).toList();
      } catch (e) {
        print('Error loading event titles: $e');
      }

      setState(
          () {}); // Trigger a rebuild to update the UI with the loaded titles
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const BottomNavBar(index: 0),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Привет: ' + (user?.email ?? 'Unknown'),
                style: TextStyle(fontSize: 20),
              ),
              // Add spacing above the ListView
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  child: ListView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // Disable scrolling for the inner ListView
                    shrinkWrap:
                        true, // Use shrinkWrap to allow the inner ListView to scroll inside the Column
                    itemCount: eventTitles.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailedEventScreen(
                                title: eventTitles[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: ListTile(
                            title: Text(
                              eventTitles[index],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: Icon(Icons.arrow_forward),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
