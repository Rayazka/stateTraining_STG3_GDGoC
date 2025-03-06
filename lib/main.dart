import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginState()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context);

    return MaterialApp(
      home: loginState.loggedIn ? MainPage() : LoginPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 248, 255),
      appBar: AppBar(
        title: const Text('Cat Profile'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.indigoAccent,
          fontSize: 24,
        ),
        backgroundColor: const Color.fromARGB(255, 240, 248, 255),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              loginState.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/dabdabcat.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'DabDabDabi Cat',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigoAccent,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Islamic Cat',
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                final loginState =
                    Provider.of<LoginState>(context, listen: false);
                loginState.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 240, 248, 255),
        selectedItemColor: Colors.indigoAccent,
        unselectedItemColor: Colors.indigoAccent,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () => _launchURL('https://www.instagram.com'),
            ),
            label: 'Instagram',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.videocam),
              onPressed: () => _launchURL('https://www.youtube.com'),
            ),
            label: 'YouTube',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () => _launchURL('https://www.facebook.com'),
            ),
            label: 'Facebook',
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
