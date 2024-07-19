import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tasklist_recipes_chat/core/constants/methods.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/core/errors/server_failure.dart';
import 'package:tasklist_recipes_chat/core/errors/unauthorized_failure.dart';
import 'package:tasklist_recipes_chat/core/errors/unknown_failure.dart';
import 'package:tasklist_recipes_chat/features/media/domain/repos/media_repo.dart';
import 'package:tasklist_recipes_chat/features/media/domain/use_cases/get_media_use_case.dart';

class MediaController {
  final MediaRepo mediaRepo;

  MediaController({required this.mediaRepo});
  Future<void> getMedia({
    required int page,
    required int limit,
    required PagingController controller,
    required BuildContext context,
  }) async {
    final response =
        await GetMediaUseCase(mediaRepo: mediaRepo).call(page, limit);
    response.fold((failure) async {
      logger.e('Error: ${failure.message}');
      switch (failure.runtimeType) {
        case const (ServerFailure):
          controller.error = failure.message;
          break;
        case const (UnauthorizedFailure):
          await checkToken(context: context);
          break;
        default:
          controller.error = failure.message;
          break;
      }
    }, (mediaList) {
      final isLastPage = mediaList.length < limit;
      if (isLastPage) {
        controller.appendLastPage(mediaList);
      } else {
        final nextPageKey = page * limit + mediaList.length;
        controller.appendPage(mediaList, nextPageKey);
      }
    });
  }

  Future<void> uploadMedia({
    required String name,
    required XFile media,
    required BuildContext context,
    required PagingController pageController,
  }) async {
    showLoadingQuickAlert(context: context);
    final response = await mediaRepo.uploadMedia(name: name, media: media);
    response.fold((failure) async {
      logger.e('Error: ${failure.message}');
      switch (failure.runtimeType) {
        case const (ServerFailure):
          await showErrorQuickAlert(
            context: context,
            text: failure.message,
          );
          break;
        case const (UnauthorizedFailure):
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          await checkToken(context: context);
          break;
        case const (UnknownFailure):
          await showErrorQuickAlert(
            context: context,
            text: failure.message,
          );
          break;
        default:
          await showErrorQuickAlert(
            context: context,
            text: failure.toString(),
          );
          break;
      }
    }, (_) async {
      Navigator.of(context).pop();
      pageController.refresh();
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Media uploaded successfully',
        showConfirmBtn: false,
        barrierDismissible: false,
        autoCloseDuration: const Duration(seconds: 3),
      );
    });
  }

  Future<void> deleteMedia({
    required String id,
    required BuildContext context,
    required PagingController pageController,
  }) async {
    showLoadingQuickAlert(context: context);
    final response = await mediaRepo.deleteMedia(id: id);
    response.fold((failure) async {
      logger.e('Error: ${failure.message}');
      switch (failure.runtimeType) {
        case const (ServerFailure):
          await showErrorQuickAlert(
            context: context,
            text: failure.message,
          );
          break;
        case const (UnauthorizedFailure):
          await checkToken(context: context);
          break;
        case const (UnknownFailure):
          await showErrorQuickAlert(
            context: context,
            text: failure.message,
          );
          break;
        default:
          await showErrorQuickAlert(
            context: context,
            text: failure.toString(),
          );
          break;
      }
    }, (_) async {
      Navigator.of(context).pop();
      pageController.refresh();
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Media deleted successfully',
        showConfirmBtn: false,
        barrierDismissible: false,
        autoCloseDuration: const Duration(seconds: 3),
      );
    });
  }
}
