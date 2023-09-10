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

  const ExpandedImagePage(
      {super.key, required this.imageUrl,
      required this.profileDisplayName,
      required this.profileUserName,
      required this.profilePictureUrl,
      required this.boltDescription,
      required this.likes,
      required this.reposts,});

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
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes!
                    ),
                  ),
                ),

                imageProvider: NetworkImage(imageUrl),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2.0,
              ),
            ),
            Visibility(visible: false, child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(profilePictureUrl),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(profileDisplayName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text(profileUserName,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14))
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Flexible(
                            child: Text(boltDescription!,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.clip))
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.favorite_rounded, color: Colors.white, size: 36),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          likes.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins", color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        const Icon(Icons.repeat_rounded, color: Colors.white, size: 36,),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          reposts.toString(),
                          style: const TextStyle(
                              fontFamily: "Poppins", color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 50),
                        const Icon(Icons.ios_share, color: Colors.white, size: 36)
                      ],
                    ),
                    const SizedBox(height: 30)
                  ],
                )))
            
          ],
        ));
  }
}
//need to implement error handling in this if the image fails to load or anything like that