
class Tweet {
  String id;
  String displayName;
  String username;
  String userProfileImageUrl; //temporarily leaving this
  String postText = "";
  String? imageUrl;
  DateTime timeOfTweet = DateTime.now(); //this too
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
