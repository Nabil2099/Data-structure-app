import 'package:flutter/material.dart';
import 'package:datastructure/pages/homepage.dart';
import 'package:datastructure/pages/arraypage.dart';
import 'package:datastructure/pages/linkedlistpage.dart';
import 'package:datastructure/pages/stackpage.dart';
import 'package:datastructure/pages/queuepage.dart';
import 'package:datastructure/pages/aboutpage.dart';
import 'package:lucide_icons/lucide_icons.dart';
class MyDrawer extends StatefulWidget {

  const MyDrawer({super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF121212),
      child: Center(
        child: ListView(
          padding: EdgeInsets.all(5),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF121212),
              ),
              child: Center(
                child: Text(
                  'Data Structures',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Homepage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.data_array, color: Colors.white),
              title:
                  const Text('Array', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Arraypage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.format_list_numbered, color: Colors.white),
              title:
                  const Text('Linked List', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LinkedListPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.squareStack, color: Colors.white),
              title:
                  const Text('Stack', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const StackPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.queue, color: Colors.white),
              title:
                  const Text('Queue', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const QueuePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.info, color: Colors.white),
              title:
                  const Text('About', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

