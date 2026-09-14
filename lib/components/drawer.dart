import 'package:flutter/material.dart';
import 'package:datastructure/pages/homepage.dart';
import 'package:datastructure/pages/aboutpage.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF121212),
      child: ListView(
        padding: const EdgeInsets.all(5),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF121212)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.data_object, color: Color(0xFF3FB950), size: 40),
                  SizedBox(height: 8),
                  Text(
                    'DSA App V2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Learn → Visualize → Practice',
                      style: TextStyle(color: Colors.white54, fontSize: 11)),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home Dashboard', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          ListTile(
            leading: const Icon(Icons.data_usage, color: Colors.white),
            title: const Text('Data Structures', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Homepage(initialShowAlgorithms: false),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.code, color: Colors.white),
            title: const Text('Algorithms', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Homepage(initialShowAlgorithms: true),
                ),
              );
            },
          ),
          const Divider(color: Colors.white12),
          ListTile(
            leading: const Icon(Icons.quiz, color: Colors.white),
            title: const Text('Practice Mode', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(context).pop();
              // Navigate via AppShell tab 2
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Use bottom navigation → Practice tab')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics, color: Colors.white),
            title: const Text('Progress', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Use bottom navigation → Progress tab')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.smart_toy, color: Colors.white),
            title: const Text('AI Tutor', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Use bottom navigation → AI Tutor tab or FAB')),
              );
            },
          ),
          const Divider(color: Colors.white12),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.white),
            title: const Text('About', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
