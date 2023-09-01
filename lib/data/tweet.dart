
import 'package:cloud_firestore/cloud_firestore.dart';

class Tweet {
  String id;
  String displayName;
  String username;
  String userProfileImageUrl;
  String postText = "";
  String? imageUrl;
  Timestamp timeOfTweet; //this too
  int likes = 0;
  int retweets = 0;

  Tweet(
      {required this.id,
        required this.username,
      required this.displayName,
      required this.userProfileImageUrl,
      required this.postText,
      required this.timeOfTweet,
      required this.likes,
      required this.retweets,
      this.imageUrl});
}
