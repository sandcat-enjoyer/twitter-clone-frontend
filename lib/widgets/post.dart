import 'dart:io';
import 'dart:ui' as ui;

import "dart:typed_data";
import "dart:async";

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:pasteboard/pasteboard.dart';
import 'package:share_plus/share_plus.dart';
import 'package:twitter_clone/data/tweet.dart';
import 'package:twitter_clone/widgets/expandedImagePage.dart';
import "package:clipboard/clipboard.dart";

class Post extends StatelessWidget {
  late final Tweet bolt;
  Uint8List? imageBytes;

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
          SnackBar(content: Text("Image was saved to the device.")));
    } catch (e) {
      print("Error saving image. $e");
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
                              )));
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: Text("Image Options",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "SF Pro",
                              )),
                          content: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.save),
                                  title: Text("Save Image",
                                      style: TextStyle(fontFamily: "SF Pro")),
                                  onTap: () {
                                    _saveImageToGallery(context);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.copy),
                                  title: Text("Copy Image",
                                      style: TextStyle(fontFamily: "SF Pro")),
                                  onTap: () {
                                    copyToClipboard();
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.ios_share),
                                  title: Text("Share Image",
                                      style: TextStyle(fontFamily: "SF Pro")),
                                  onTap: () {
                                    //this code needs to be modified to work still on ipads
                                    final box = context.findRenderObject()
                                        as RenderBox?;
                                    Share.share(
                                        "<here goes the image you want to share :3>",
                                        sharePositionOrigin:
                                            box!.localToGlobal(Offset.zero) &
                                                box.size);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.add_a_photo),
                                  title: Text("Add Image to Bolt",
                                      style: TextStyle(fontFamily: "SF Pro")),
                                  onTap: () {
                                    //logic to save image to device
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          )));
                },
              ),
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
                              )));
                },
                onLongPress: () {
                  final RenderBox overlay = Overlay.of(context)
                      .context
                      .findRenderObject() as RenderBox;
                  showMenu(
                      context: context,
                      position: RelativeRect.fromRect(
                          Rect.fromPoints(
                              overlay.localToGlobal(Offset.zero),
                              overlay.localToGlobal(
                                  overlay.size.bottomRight(Offset.zero))),
                          Offset.zero & overlay.size),
                      items: <PopupMenuItem>[
                        PopupMenuItem(child: Text("Save Image"))
                      ]);
                },
              ),
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
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double screenWidth = mediaQueryData.size.width;
    final double tabletWidthThreshold = 600.0;

    if (screenWidth > tabletWidthThreshold) {
      // Return tablet layout
      return _buildTabletPosts(context);
    } else {
      // Return phone layout
      return _buildPhonePosts(context);
    }
  }
}
