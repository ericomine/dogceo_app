import 'package:flutter/material.dart';

import '../../widgets/circle_network_image.dart';

class ActionableImage extends StatefulWidget {
  final void Function(String)? onShareImage;
  final String imagePath;

  const ActionableImage({Key? key, this.onShareImage, required this.imagePath})
      : super(key: key);

  @override
  _ActionableImageState createState() => _ActionableImageState();
}

class _ActionableImageState extends State<ActionableImage> {
  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    return showMenu
        ? ActionableMenu(
            imagePath: widget.imagePath,
            onCloseMenu: () => setState(() => showMenu = false),
            onShareImage: widget.onShareImage,
          )
        : GestureDetector(
            onTap: !showMenu ? () => setState(() => showMenu = true) : null,
            child: CircleNetworkImage(imagePath: widget.imagePath));
  }
}

class ActionableMenu extends StatelessWidget {
  final void Function() onCloseMenu;
  final void Function(String)? onShareImage;
  final String imagePath;

  const ActionableMenu({
    Key? key,
    required this.onCloseMenu,
    this.onShareImage,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          color: Theme.of(context).accentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(Icons.chevron_left), onPressed: onCloseMenu),
              IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => onShareImage?.call(imagePath)),
            ],
          ),
        ),
      ),
    );
  }
}
