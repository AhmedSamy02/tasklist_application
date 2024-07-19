import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/media/data/models/media.dart';
import 'package:tasklist_recipes_chat/features/media/presentation/controllers/media_controller.dart';

class MediaListItem extends StatelessWidget {
  const MediaListItem(
      {super.key, required this.media, required this.pagingController});
  final PagingController pagingController;
  final Media media;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(18.sp),
      height: 150.h,
      width: double.infinity,
      color: Colors.grey[200],
      child: Column(
        children: [
          Row(
            children: [
              Text(
                media.name!,
                style: GoogleFonts.cookie(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900]),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    getit.get<MediaController>().deleteMedia(
                          id: media.id!,
                          context: context,
                          pageController: pagingController,
                        );
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.redAccent[700],
                    size: 40.sp,
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.sp),
            child: CachedNetworkImage(
              imageUrl: media.mediaLink!,
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorListener: (value) {},
              progressIndicatorBuilder: (context, url, progress) =>
                  SpinKitFadingCircle(
                color: Colors.blueGrey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
