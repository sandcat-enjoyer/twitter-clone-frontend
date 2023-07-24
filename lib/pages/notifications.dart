import 'package:flutter/material.dart';
import 'package:twitter_clone/data/user.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      profileImageUrl:
          'https://pbs.twimg.com/profile_images/1667776665768869888/Vqf4ewyl_400x400.jpg',
      username: 'Meowings',
      notificationText: 'liked your tweet: "Business Opportunity"',
      timestamp: '2h',
    ),
    NotificationItem(
      profileImageUrl:
          'https://pbs.twimg.com/profile_images/1683405816886358017/taWzjldB_400x400.jpg',
      username: 'MAX',
      notificationText: 'mentioned you in a tweet: "New store . Check it out"',
      timestamp: '5h',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return NotificationCard(
          notification: notifications[index],
        );
      },
    );
  }
}

class NotificationItem {
  final String profileImageUrl;
  final String username;
  final String notificationText;
  final String timestamp;

  NotificationItem({
    required this.profileImageUrl,
    required this.username,
    required this.notificationText,
    required this.timestamp,
  });
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  const NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: Border(
        bottom: BorderSide(color: Colors.grey, width: 0.5),
      ),
      contentPadding: EdgeInsets.all(10.0),
      tileColor: Colors.black,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(notification.profileImageUrl),
      ),
      title: Text(
        '${notification.username} ${notification.notificationText}',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      subtitle:
          Text(notification.timestamp, style: TextStyle(color: Colors.white)),
      trailing: Icon(
        Icons.favorite,
        color: Colors.pink,
      ),
    );
  }
}
