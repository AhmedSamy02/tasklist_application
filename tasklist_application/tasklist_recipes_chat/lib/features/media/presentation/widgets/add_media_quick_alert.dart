import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/features/media/presentation/controllers/media_controller.dart';

class AddMediaQuickAlert extends QuickAlert {
  static Future<void> show({
    required BuildContext context,
    required TextEditingController nameController,
    required ImagePicker picker,
    required PagingController pageController,
  }) {
    XFile? file;
    return QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      title: 'Add Media',
      customAsset: 'assets/gifs/add_media.gif',
      text: 'Add media to your library',
      widget: Column(
        children: [
          SizedBox(height: 18.h),
          TextFormField(
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: Colors.blueGrey[800],
            decoration: InputDecoration(
              labelText: 'Name',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.dg),
                borderSide:
                    BorderSide(color: Colors.blueGrey[800]!, width: 2.sp),
              ),
              floatingLabelStyle: TextStyle(
                color: Colors.blueGrey[800],
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.dg),
                borderSide:
                    BorderSide(color: Colors.blueGrey[800]!, width: 2.sp),
              ),
              focusColor: Colors.blueGrey[600],
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async {
                    file = await picker.pickImage(source: ImageSource.camera);
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800],
                    shape: const CircleBorder(),
                  ),
                  icon: Icon(Icons.camera, size: 50.sp, color: Colors.white),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800],
                    shape: const CircleBorder(),
                  ),
                  onPressed: () async {
                    file = await picker.pickImage(source: ImageSource.gallery);
                  },
                  icon: Icon(Icons.image, size: 50.sp, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      showCancelBtn: true,
      confirmBtnColor: Colors.blueGrey[800]!,
      onConfirmBtnTap: () async {
        if (nameController.text.isEmpty || file == null) {
          await QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: 'The name and media are required',
          );
          return;
        }
        await getit.get<MediaController>().uploadMedia(
            name: nameController.text,
            media: file!,
            context: context,
            pageController: pageController);
        Navigator.of(context).pop();
      },
    );
  }
}
