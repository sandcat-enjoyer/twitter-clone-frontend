import 'dart:io';

import "dart:async";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spark/data/tweet.dart';
import 'package:spark/widgets/expandedImagePage.dart';

class Post extends StatelessWidget {
  late final Tweet bolt;
  Uint8List? imageBytes;
  bool _isLiked = false;

  Post(this.bolt, {super.key});

  _checkScreenSize(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;
    double tabletWidthThreshold = 600.0;
    
    print('Ermmm the screen size it is $screenWidth');

    if (screenWidth > tabletWidthThreshold) {
      return _buildTabletPosts(context);
    } else {
      return _buildPhonePosts(context);
    }
  }

  Future<Uint8List> networkImageToUint8List(String imageUrl) async {
    // Make a network request to get the image data.
    final http.Response response = await http.get(Uri.parse(imageUrl));

    // Check if the request was successful.
    if (response.statusCode == 200) {
      // Convert the response body (image data) to Uint8List.
      print("response success");
      return response.bodyBytes;
    } else {
      // If the request failed, you can handle the error accordingly.
      throw Exception('Failed to load image: ${response.statusCode}');
    }
  }

  loadImageAndConvertToUint8List() async {
    try {
      imageBytes = await networkImageToUint8List(bolt.imageUrl!);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> copyToClipboard() async {
    await loadImageAndConvertToUint8List();
    //i don't entirely know why copying an image isn't working, may need to just drop this functionality
    if (Platform.isIOS) {
      print(imageBytes);
      await Pasteboard.writeImage(imageBytes);
    }
  }

  Future<void> _saveImageToGallery(BuildContext context) async {
    try {
      final http.Response response = await http.get(Uri.parse(bolt.imageUrl!));
      final Uint8List bytes = response.bodyBytes;

      await ImageGallerySaver.saveImage(Uint8List.fromList(response.bodyBytes));

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Image was saved to the device.")));
    } catch (e) {
      print("Error saving image. $e");
    }
  }

  _buildTabletPosts(BuildContext context) {
    return Center(
      child: Container(
        width: 450,
        child: Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(bolt.userProfileImageUrl),
                ),
                const SizedBox(width: 8),
                Text(
                  bolt.displayName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  bolt.username,
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ],
            ),
            const SizedBox(height: 8),
            SelectableText(
              bolt.postText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 4,
            ),
            
            if (bolt.imageUrl != null) ...[
              const SizedBox(height: 8),
              GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    bolt.imageUrl!,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExpandedImagePage(
                                imageUrl: bolt.imageUrl!,
                                profileDisplayName: bolt.displayName,
                                profilePictureUrl: bolt.userProfileImageUrl,
                                profileUserName: bolt.username,
                                boltDescription: bolt.postText,
                                likes: bolt.likes,
                                reposts: bolt.retweets,
                          
                              )));
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: const Text("Image Options",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              )),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.save),
                                      title: const Text("Save Image",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16)),
                                      onTap: () {
                                        _saveImageToGallery(context);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.copy),
                                      title: const Text("Copy Image",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16)),
                                      onTap: () {
                                        copyToClipboard();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.ios_share),
                                      title: const Text("Share Image",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16)),
                                      onTap: () {
                                        //this code needs to be modified to work still on ipads
                                        final box = context.findRenderObject()
                                            as RenderBox?;
                                        Share.share(
                                            "<here goes the image you want to share :3>",
                                            sharePositionOrigin: box!
                                                    .localToGlobal(
                                                        Offset.zero) &
                                                box.size);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.add_a_photo),
                                      title: const Text("Add Image to Bolt",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16)),
                                      onTap: () {
                                        //logic to save image to device
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          )));
                },
              ),
            ],
            const SizedBox(height: 16.0),
            Text(
              "${DateFormat.yMMMd().format(bolt.timeOfTweet)}, ${DateFormat.Hm().format(bolt.timeOfTweet)}",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Row(
                    children: [
                      Icon(Icons.favorite_rounded,
                          size: 30.0,
                          color: _isLiked ? Colors.red : Theme.of(context).primaryIconTheme.color),
                      const SizedBox(width: 8),
                      Text(
                        "${bolt.likes}",
                        style: TextStyle(
                            fontSize: 24,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                    ],
                  ),
                  onPressed: () {
                    if (_isLiked) {
                      FirebaseFirestore.instance
                        .collection("posts")
                        .doc(bolt.id)
                        .update({
                          "likes": FieldValue.increment(1),
                          "likedBy": FieldValue.arrayUnion(["userID"]) // still needs a real user id
                        });
                    }
                    else {
                      FirebaseFirestore.instance
                        .collection("posts")
                        .doc(bolt.id)
                        .update({
                          "likes": FieldValue.increment(-1),
                          "likedBy": FieldValue.arrayRemove(["userID"])
                        });
                    }

                

                  },
                ),
                TextButton(
                  child: Row(
                    children: [
                      Icon(Icons.repeat_rounded,
                          size: 30.0,
                          color: Theme.of(context).primaryIconTheme.color),
                      const SizedBox(
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
    ),
      ) 
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
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(bolt.userProfileImageUrl),
                ),
                const SizedBox(width: 8),
                Text(
                  bolt.displayName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Poppins"),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  bolt.username,
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              bolt.postText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 4,
            ),
            
            if (bolt.imageUrl != null) ...[
              const SizedBox(height: 8),
              GestureDetector(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(bolt.imageUrl!),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExpandedImagePage(
                              imageUrl: bolt.imageUrl!,
                              profileDisplayName: bolt.displayName,
                              profilePictureUrl: bolt.userProfileImageUrl,
                              profileUserName: bolt.username,
                              boltDescription: bolt.postText,
                              likes: bolt.likes,
                              reposts: bolt.retweets,)));
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: const Text("Image Options",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              )),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.save),
                                      title: const Text("Save Image",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16)),
                                      onTap: () {
                                        _saveImageToGallery(context);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.copy),
                                      title: const Text("Copy Image",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16)),
                                      onTap: () {
                                        copyToClipboard();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.ios_share),
                                      title: const Text("Share Image",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16)),
                                      onTap: () {
                                        //this code needs to be modified to work still on ipads
                                        final box = context.findRenderObject()
                                            as RenderBox?;
                                        Share.share(
                                            "<here goes the image you want to share :3>",
                                            sharePositionOrigin: box!
                                                    .localToGlobal(
                                                        Offset.zero) &
                                                box.size);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.add_a_photo),
                                      title: const Text("Add Image to Bolt",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16)),
                                      onTap: () {
                                        //logic to save image to device
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          )));
                },
              ),
            const SizedBox(height: 16)
            ],
            
            Text(
              "${DateFormat.yMMMd().format(bolt.timeOfTweet)}, ${DateFormat.Hm().format(bolt.timeOfTweet)}",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 16),
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
                      const SizedBox(width: 8),
                      Text(
                        "${bolt.likes}",
                        style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).primaryIconTheme.color),
                      ),
                    ],
                  ),
                  onPressed: () {
                    if (_isLiked) {
                      _isLiked = true;
                      FirebaseFirestore.instance
                        .collection("posts")
                        .doc(bolt.id)
                        .update({
                          "likes": FieldValue.increment(1),
                          "likedBy": FieldValue.arrayUnion(["userID"]) // still needs a real user id
                        });
                    }
                    else {
                      FirebaseFirestore.instance
                        .collection("posts")
                        .doc(bolt.id)
                        .update({
                          "likes": FieldValue.increment(-1),
                          "likedBy": FieldValue.arrayRemove(["userID"])
                        });
                    }
                  },
                ),
                const SizedBox(width: 30),
                TextButton(
                  child: Row(
                    children: [
                      Icon(Icons.repeat_rounded,
                          size: 30.0,
                          color: Theme.of(context).primaryIconTheme.color),
                      const SizedBox(
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
                const SizedBox(
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
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double screenWidth = mediaQueryData.size.width;
    const double tabletWidthThreshold = 600.0;

    if (screenWidth > tabletWidthThreshold) {
      // Return tablet layout
      return _buildTabletPosts(context);
    } else {
      // Return phone layout
      return _buildPhonePosts(context);
    }
  }
}
