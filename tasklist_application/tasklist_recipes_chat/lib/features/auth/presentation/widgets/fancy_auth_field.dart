import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FancyAuthField extends StatelessWidget {
  const FancyAuthField({super.key, required this.passwordController, required this.facnyTextEditingController});
  final TextEditingController passwordController;
  final FancyPasswordController facnyTextEditingController;
  @override
  Widget build(BuildContext context) {
    return FancyPasswordField(
      validationRuleBuilder: (rules, value) {
        // if (value.isEmpty) {
        //   return const SizedBox.shrink();
        // }
        return Padding(
          padding: EdgeInsets.only(top: 18.sp),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            children: rules
                .map(
                  (rule) => rule.validate(value)
                      ? Container(
                          padding: EdgeInsets.symmetric(vertical: 6.sp),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.green[800],
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                rule.name,
                                style: TextStyle(
                                  color: Colors.green[800]!,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(3.sp),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 6.sp),
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  rule.name,
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                )
                .toList(),
          ),
        );
      },
      hasStrengthIndicator: false,
      controller: passwordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      passwordController: facnyTextEditingController,
      validator: (value) {
        if (value == null|| value.isEmpty) {
          return 'Please enter your password';
        }
        return facnyTextEditingController.areAllRulesValidated
            ? null
            : 'Validation rules aren\'t met';
      },
      validationRules: {
        DigitValidationRule(),
        UppercaseValidationRule(),
        LowercaseValidationRule(),
        SpecialCharacterValidationRule(),
        MinCharactersValidationRule(8),
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: 'Password',
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
