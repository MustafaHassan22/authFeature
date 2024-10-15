import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smp/core/helper_methods.dart';
import 'package:smp/core/styles.dart';
import 'package:smp/core/widgets/custom_main_btn.dart';
import 'package:smp/gen/assets.gen.dart';
import 'package:smp/generated/locale_keys.g.dart';
import 'package:smp/routes/app_routes.dart';
import 'package:smp/widgets/have_account_or_not.dart';
import 'package:smp/widgets/main_button.dart';
import 'package:smp/widgets/social_button.dart';

class LoginOrSignUpScreen extends StatelessWidget {
  const LoginOrSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const SizedBox(height: 60, child: HaveAccountOrNot(isHave: true)),
      body: SingleChildScrollView(
        padding:
            EdgeInsetsDirectional.only(start: 16.sp, end: 16.sp, top: 110.sp),
        child: Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.svg.loginOrSignUp),
                const SizedBox(
                  height: 67,
                ),
                CustomMainBtn(
                  onClick: () {
                    navigateTo(context, page: Routes.login);
                  },
                  text: LocaleKeys.login.tr(),
                ),
                const SizedBox(
                  height: 45,
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 52),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 100,
                          child: Divider(
                              color: AppColors.blackText, thickness: 1)),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text('OR'),
                      const SizedBox(
                        width: 11,
                      ),
                      SizedBox(
                          width: 100,
                          child: Divider(
                              color: AppColors.blackText, thickness: 1)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomMainBtn(
                  onClick: () {},
                  backgroundColor: AppColors.google,
                  text: LocaleKeys.continueWithGoogle.tr(),
                  icon: Assets.svg.google,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomMainBtn(
                  onClick: () {},
                  backgroundColor: AppColors.greyText,
                  text: LocaleKeys.continueWithApple.tr(),
                  icon: Assets.svg.apple,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
