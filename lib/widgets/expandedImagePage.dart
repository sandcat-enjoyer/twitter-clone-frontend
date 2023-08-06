import "package:flutter/material.dart";
import "package:photo_view/photo_view.dart";

class ExpandedImagePage extends StatelessWidget {
  final String imageUrl;
  final String profileDisplayName;
  final String profileUserName;
  final String profilePictureUrl;
  final String? boltDescription;

  ExpandedImagePage(
      {required this.imageUrl,
      required this.profileDisplayName,
      required this.profileUserName,
      required this.profilePictureUrl,
      required this.boltDescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              boltDescription!,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}
//need to implement error handling in this if the image fails to load or anything like that