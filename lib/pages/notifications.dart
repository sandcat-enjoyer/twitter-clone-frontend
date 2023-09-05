import 'package:flutter/material.dart';
import 'package:spark/data/user.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:spark/data/notification_item.dart';
import "package:spark/widgets/notification.dart";


class Notifications extends StatefulWidget {
  const Notifications({Key? key, required UserLocal user})
      : _user = user,
        super(key: key);

  final UserLocal _user;

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();

  final List<NotificationItem> notifications = [
    NotificationItem(
      profileImageUrl:
          'https://pbs.twimg.com/profile_images/1438646762080772098/xAwDFg3d_400x400.jpg',
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
    return RefreshIndicator(
      backgroundColor: Colors.black87,
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(
            notification: notifications[index],
          );
        },
      ),
      onRefresh: () async {
        await audioPlayer.play(AssetSource("sound/spark_refresh_sound_start.mp3")).then((value) {
          Future.delayed(const Duration(seconds: 2)).then((value) {
            audioPlayer.play(AssetSource("sound/spark_refresh_sound_end.mp3"));

          });
        });

      },
    );
  }
}




