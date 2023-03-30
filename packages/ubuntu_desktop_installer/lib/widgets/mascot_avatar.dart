import 'package:flutter/material.dart';

const _kMascotAsset = AssetImage('assets/mascot.png');

class MascotAvatar extends StatelessWidget {
  const MascotAvatar(
      {super.key, this.image = _kMascotAsset, this.height = 160});

  final ImageProvider<Object> image;
  final double height;

  /// Requests the mascot asset to be pre-cached.
  static Future precacheAsset(BuildContext context) async {
    return precacheImage(_kMascotAsset, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.outline,
      ),
      child: Image(image: image, gaplessPlayback: true, height: height),
    );
  }
}
