import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ProfileWidget extends StatelessWidget {
  //final String backgroundPath;
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;
  final double coverHeight = 200;
  final double profileHeight = 144;

  const ProfileWidget({
    Key? key,
    //required this.backgroundPath,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final double top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImage(),
          ),
          Positioned(top: top, child: buildImage()),
          Positioned(bottom: 0, right: 150, child: buildEditIcon(color)),
        ]);
  }

  Widget buildImage() {
    final image = imagePath.contains('assets/')
        ? AssetImage(imagePath)
        : FileImage(File(imagePath));
    return ClipOval(
        child: Material(
      color: Colors.transparent,
      child: Ink.image(
        image: image as ImageProvider,
        fit: BoxFit.cover,
        width: 128,
        height: 128,
        child: InkWell(onTap: onClicked),
      ),
    ));
  }

  Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 8,
        child: Icon(
          isEdit ? Icons.add_a_photo : Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  // Widget buildCoverImage() => Container(
  //    color: Colors.grey,
  //  child: Image(
  // image: AssetImage('assets/tree.jpg'),
  // width: double.infinity,
  // height: coverHeight,
  //   fit: BoxFit.cover,
  //   ));

  Widget buildCoverImage() {
    final Backimage = AssetImage('assets/oic.JPG');
    return Container(
        color: Colors.grey,
        child: Image(
          //image: AssetImage('assets/tree.jpg'),
          image: Backimage,
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
          // child: InkWell(onTap: onClicked),
        ));
  }
}
