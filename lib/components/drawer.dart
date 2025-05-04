import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  final hometap;
  final arraytap;
  final linkedlisttap;
  final stacktap;
  final queuetap;
  const MyDrawer({super.key,
  required this.hometap,
  required this.arraytap,
  required this.linkedlisttap,
  required this.stacktap,
  required this.queuetap,
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
                widget.hometap();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title:
                  const Text('Array', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle array tap
                widget.arraytap();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title:
                  const Text('Linked List', style: TextStyle(color: Colors.white)),
              onTap: () {
                widget.linkedlisttap();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title:
                  const Text('Stack', style: TextStyle(color: Colors.white)),
              onTap: () {
                widget.stacktap();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title:
                  const Text('Queue', style: TextStyle(color: Colors.white)),
              onTap: () {
                widget.queuetap();
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.info, color: Colors.white),
              title:
                  const Text('About', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle about tap
              },
            ),
          ],
        ),
      ),
    );
  }
}

