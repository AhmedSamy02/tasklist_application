import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tasklist_recipes_chat/features/media/data/models/media.dart';
import 'package:tasklist_recipes_chat/features/media/presentation/widgets/loading_media_item.dart';
import 'package:tasklist_recipes_chat/features/media/presentation/widgets/media_list_item.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key, required this.pagingController});
  final PagingController pagingController;
  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {



  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        widget.pagingController.refresh();
        return;
      },
      child: PagedListView(
        pagingController: widget.pagingController,
        builderDelegate: PagedChildBuilderDelegate<Media>(
          noItemsFoundIndicatorBuilder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_not_supported,
                  size: 150.sp,
                  color: Colors.blueGrey[600],
                ),
                SizedBox(height: 10.h),
                Text(
                  'No Media Found',
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.blueGrey[900],
                  ),
                ),
              ],
            );
          
          },
          itemBuilder: (context, media, index) {
            return MediaListItem(
              media: media,
              pagingController: widget.pagingController,
            );
          },
          firstPageProgressIndicatorBuilder: (context) {
            return const Column(
              children: [
                LoadingMediaItem(),
                LoadingMediaItem(),
                LoadingMediaItem(),
              ],
            );
          },
        ),
      ),
    );
  }
}
