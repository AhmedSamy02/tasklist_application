import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tasklist_recipes_chat/core/constants/methods.dart';
import 'package:tasklist_recipes_chat/core/constants/values.dart';
import 'package:tasklist_recipes_chat/core/errors/server_failure.dart';
import 'package:tasklist_recipes_chat/core/errors/unauthorized_failure.dart';
import 'package:tasklist_recipes_chat/core/errors/unknown_failure.dart';
import 'package:tasklist_recipes_chat/features/recipies/domain/use_cases/get_recipies_use_case.dart';

class RecipiesController {
  final GetRecipiesUseCase getRecipiesUseCase;

  RecipiesController({required this.getRecipiesUseCase});
  Future<void> getRecipies({
    required int page,
    required int limit,
    required PagingController controller,
    required BuildContext context,
  }) async {
    final useCase = await getRecipiesUseCase.call(page ~/ limit, limit);

    useCase.fold(
      (failure) async {
        logger.e('Error: ${failure.message}');
        switch (failure.runtimeType) {
          case const (ServerFailure):
            controller.error = failure.message;
            break;
          case const (UnauthorizedFailure):
            await checkToken(context: context);
            break;
          case const (UnknownFailure):
            controller.error = failure.message;
            break;
          default:
            controller.error = failure.toString();
            break;
        }
      },
      (recipies) {
        final isLastPage = recipies.length < limit;
        if (isLastPage) {
          controller.appendLastPage(recipies);
        } else {
          final nextPageKey = page * limit + recipies.length;
          controller.appendPage(recipies, nextPageKey);
        }
      },
    );
  }
}
