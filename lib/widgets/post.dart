import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/data/tweet.dart';

class Post extends StatelessWidget {
  late final Tweet bolt;

  Post(this.bolt);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(bolt.userProfileImageUrl),
                ),
                SizedBox(width: 8),
                Text(
                  bolt.displayName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "SF Pro"),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  bolt.username,
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ],
            ),
            SizedBox(height: 8),
            Text(
              bolt.postText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "${DateFormat.yMMMd().format(bolt.timeOfTweet) + ", " + DateFormat.Hm().format(bolt.timeOfTweet)}",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            if (bolt.imageUrl != null) ...[
              SizedBox(height: 8),
              Image.network(bolt.imageUrl!)
            ],
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(
                  Icons.favorite_rounded,
                  size: 30.0,
                ),
                SizedBox(
                  width: 4,
                ),
                Text("${bolt.likes} Likes"),
                SizedBox(width: 15),
                Icon(
                  Icons.repeat,
                  size: 30.0,
                ),
                SizedBox(
                  width: 4,
                ),
                Text("${bolt.retweets} Reposts")
              ],
            )
          ],
        ),
      ),
    );
  }
}