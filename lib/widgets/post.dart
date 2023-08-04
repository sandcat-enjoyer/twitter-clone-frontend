import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:twitter_clone/data/tweet.dart';

class Post extends StatelessWidget {
  late final Tweet bolt;

  Post(this.bolt);

  _checkScreenSize(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double tabletWidthThreshold = 600.0;
    print("${'Ermmm the screen size it is ' + screenWidth.toString()}");

    if (screenWidth > tabletWidthThreshold) {
      return _buildTabletPosts(context);
    } else {
      return _buildPhonePosts(context);
    }
  }

  _buildTabletPosts(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(bolt.imageUrl!))
            ],
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Row(
                    children: [
                      Icon(Icons.favorite_rounded,
                          size: 30.0,
                          color: Theme.of(context).primaryIconTheme.color),
                      SizedBox(width: 8),
                      Text(
                        "${bolt.likes}",
                        style: TextStyle(
                            fontSize: 24,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 30),
                TextButton(
                  child: Row(
                    children: [
                      Icon(Icons.repeat_rounded,
                          size: 30.0,
                          color: Theme.of(context).primaryIconTheme.color),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${bolt.retweets}",
                        style: TextStyle(
                            fontSize: 24,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 30,
                ),
                TextButton(
                    onPressed: () {
                      final box = context.findRenderObject() as RenderBox?;
                      Share.share("<here goes a link :3>",
                          sharePositionOrigin:
                              box!.localToGlobal(Offset.zero) & box.size);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.ios_share,
                            size: 30,
                            color: Theme.of(context).primaryIconTheme.color),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildPhonePosts(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(bolt.imageUrl!))
            ],
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_rounded,
                        size: 30.0,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${bolt.likes}",
                        style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).primaryIconTheme.color),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 30),
                TextButton(
                  child: Row(
                    children: [
                      Icon(Icons.repeat_rounded,
                          size: 30.0,
                          color: Theme.of(context).primaryIconTheme.color),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${bolt.retweets}",
                        style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).primaryIconTheme.color),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 30,
                ),
                TextButton(
                    onPressed: () {
                      Share.share("<here goes a link :3>");
                    },
                    child: Row(
                      children: [
                        Icon(Icons.ios_share,
                            size: 30,
                            color: Theme.of(context).primaryIconTheme.color),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _checkScreenSize(context);
  }
}
