import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';

class AnonymousContent extends StatelessWidget {
  final User user;
  final service = GetIt.instance.get<FirebaseService>();

  AnonymousContent({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildAvatar(),
        ListTile(
          title: const Text('User ID'),
          subtitle: Text(user.uid),
        ),
        const ListTile(
          title: Text('Warning!'),
          subtitle: Text(
            "You are logged in as an anonymous user. The data is not synced with other devices. If you delete the app, you will lose all your data.",
          ),
        ),
        _buildActionButtons(service, context),
      ],
    );
  }

  Widget _buildAvatar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircleAvatar(
          backgroundImage: user.photoURL != null
              ? NetworkImage(user.photoURL!)
              : const NetworkImage("https://picsum.photos/200"),
          radius: 50.0,
        ),
      ),
    );
  }

  Widget _buildActionButtons(FirebaseService service, BuildContext context) {
    return ListTile(
      leading: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        onPressed: () async {
          await service.deleteAnonymousUser();
        },
        child: const Text('Delete local data'),
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          context.go('/login');
        },
        child: const Text('Promote to user'),
      ),
    );
  }
}
