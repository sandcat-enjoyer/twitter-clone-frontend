import 'package:spark/data/tweet.dart';

class UserLocal {
    final String uid;
    final String displayName;
    final String username;
    final String profilePictureUrl;
    final String? headerUrl;
    final String? pronouns;
    final String? bio;


    UserLocal({
      required this.uid,
      required this.displayName,
      required this.username,
      required this.profilePictureUrl,
      required this.headerUrl,
      required this.bio,
      required this.pronouns
      
    });

    factory UserLocal.fromMap(Map<String, dynamic> map, String uid) {
      return UserLocal(  
      uid: uid, 
      displayName: map["displayname"], 
      username: map["username"], 
      profilePictureUrl: map["profilePictureUrl"],
      pronouns: map["pronouns"],
      headerUrl: map["headerImageUrl"],
      bio: map["bio"],
     );
    }


}