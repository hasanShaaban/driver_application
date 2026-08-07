import 'package:flutter/material.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
            image: imageUrl != null && imageUrl!.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
        // Positioned(
        //   right: -7,
        //   bottom: -10,
        //   child: Container(
        //     width: 46,
        //     height: 46,
        //     decoration: BoxDecoration(
        //       border: Border.all(color: Colors.white, width: 5),
        //       shape: BoxShape.circle,
        //       color: Colors.grey.shade200,
        //     ),
        //     child: Center(child: SvgPicture.asset(Assets.iconsEditLine)),
        //   ),
        // ),
      ],
    );
  }
}
