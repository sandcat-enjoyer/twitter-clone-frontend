import "package:flutter/material.dart";
import "package:photo_view/photo_view.dart";

class ExpandedImagePage extends StatelessWidget {
  final String imageUrl;
  final String profileDisplayName;
  final String profileUserName;
  final String profilePictureUrl;
  final String? boltDescription;
  final int likes;
  final int reposts;

  ExpandedImagePage(
      {required this.imageUrl,
      required this.profileDisplayName,
      required this.profileUserName,
      required this.profilePictureUrl,
      required this.boltDescription,
      required this.likes,
      required this.reposts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.black54,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: PhotoView(
                imageProvider: NetworkImage(imageUrl),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2.0,
              ),
            ),
            Container(
                color: Colors.black54,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(profilePictureUrl),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(profileDisplayName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text(profileUserName,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14))
                          ],
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Flexible(
                            child: Text(boltDescription!,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.clip))
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_rounded, color: Colors.white),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          likes.toString(),
                          style: TextStyle(
                              fontFamily: "SF Pro", color: Colors.white),
                        ),
                        SizedBox(
                          width: 160,
                        ),
                        Icon(Icons.repeat_rounded, color: Colors.white),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          reposts.toString(),
                          style: TextStyle(
                              fontFamily: "SF Pro", color: Colors.white),
                        ),
                        SizedBox(width: 160),
                        Icon(Icons.ios_share, color: Colors.white)
                      ],
                    ),
                    SizedBox(height: 30)
                  ],
                ))
          ],
        ));
  }
}
//need to implement error handling in this if the image fails to load or anything like that