import 'package:twitter_clone/data/user.dart';

class Tweet {
  User username = User(); //temporarily leaving this
  String tweetText = "";
  DateTime timeOfTweet = DateTime.now(); //this too
  int likes = 0;
  int retweets = 0;
} 