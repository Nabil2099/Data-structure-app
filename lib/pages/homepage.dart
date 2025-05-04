import 'package:datastructure/components/drawer.dart';
import 'package:datastructure/pages/arraypage.dart';
import 'package:flutter/material.dart';
import 'package:datastructure/components/container.dart';
import 'package:datastructure/components/floatingactionbutton.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        hometap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Homepage(),
            ),
          );
        },
        arraytap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Arraypage(),
            ),
          );
        },
        linkedlisttap: () {
          // Handle linked list tap
        },
        stacktap: () {
          // Handle stack tap
        },
        queuetap: () {
          // Handle queue tap
        },
      ),
      appBar: AppBar(
        title: Text('Data Structures',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0C8159),
        elevation: 4.5,
        shadowColor: Colors.white38,
      ),
      floatingActionButton: MyActionButton(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
            children: [
              MyContainer(
                paragraph: 'Learn more about arrays one of the most basic examples on data structures',
                title: 'Array',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Arraypage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              MyContainer(
                paragraph: 'Learn more about linked list and how to use it',
                title: 'Linked List',
                onPressed: () {
                },
              ),
              const SizedBox(height: 20),
              MyContainer(
                paragraph: 'Learn more about stack and how to use it',
                title: 'Stack',
                onPressed: () {
                  Navigator.pushNamed(context, '/stack');
                },
              ),
              const SizedBox(height: 20),
              MyContainer(
                paragraph: 'Learn more about queue and how to use it',
                title: 'Queue',
                onPressed: () {
                },
              ),
            ],
        ),
      ),
    );
  }
}
