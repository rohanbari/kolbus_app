import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('About Us'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Centosys',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'We bring solutions to your smartphone, making your daily life easier by providing access to local services and information through our intuitive apps.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const _InfoCard(
            icon: Icons.flag,
            title: 'Our Mission',
            content:
                'To empower individuals and communities by creating innovative and user-friendly mobile solutions that simplify everyday tasks and enhance connectivity.',
          ),
          const SizedBox(height: 20),
          const _InfoCard(
            icon: Icons.visibility,
            title: 'Our Vision',
            content:
                'To be a leading provider of mobile applications that anticipate and meet the evolving needs of our users, fostering a more connected and efficient world.',
          ),
          // const SizedBox(height: 20),
          // const _InfoCard(
          //   icon: Icons.contact_mail,
          //   title: 'Contact Us',
          //   content: 'Email: contact@centosys.com\n'
          //       'Phone: +1 (234) 567-890\n'
          //       'Website: www.centosys.com',
          // ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}