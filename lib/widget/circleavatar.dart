import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

CustomeCircleAvatar(String imageUrl) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20.0,
          // backgroundColor: Palette.facebookBlue,
          child: CircleAvatar(
            radius: true ? 17.0 : 20.0,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
        ),
        true
            ? Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
 
