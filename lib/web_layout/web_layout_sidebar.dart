import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WebLayoutSidebar extends StatelessWidget {
  const WebLayoutSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/1000"),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(''),
          ),
          const ListTile(
            title: Text('UnToggl'),
          ),
          const Divider(),
          ListTile(
            title: const Text('Dashboard'),
            onTap: () {
              context.go('/dash');
            },
          ),
          ListTile(
            title: const Text('Teams'),
            onTap: () {
              context.go('/teams');
            },
          ),
          ListTile(
            title: const Text('Calendar'),
            onTap: () {
              context.go('/calendar');
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              context.go('/profile');
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              context.go('/settings');
            },
          ),
        ],
      ),
    );
  }
}
