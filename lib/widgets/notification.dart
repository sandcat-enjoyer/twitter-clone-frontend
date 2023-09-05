import 'package:flutter/material.dart';
import "package:spark/data/notification_item.dart";

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const Border(
        bottom: BorderSide(color: Colors.grey, width: 0.5),
      ),
      contentPadding: const EdgeInsets.all(10.0),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(notification.profileImageUrl),
      ),
      title: Text('${notification.username} ${notification.notificationText}',
          style: Theme.of(context).textTheme.bodyLarge),
      subtitle:
          Text(notification.timestamp, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(
        Icons.favorite,
        color: Colors.pink,
      ),
    );
  }
}