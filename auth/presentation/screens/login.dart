import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:smp/core/helper_methods.dart';
import 'package:smp/core/styles.dart';
import 'package:smp/core/widgets/custom_large_text.dart';
import 'package:smp/core/widgets/custom_medium_text.dart';
import 'package:smp/core/widgets/custom_small_text.dart';
import 'package:smp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smp/gen/assets.gen.dart';
import 'package:smp/generated/locale_keys.g.dart';
import 'package:smp/routes/app_routes.dart';
import 'package:smp/widgets/custom_appbar.dart';
import 'package:smp/widgets/have_account_or_not.dart';
import 'package:smp/widgets/main_button.dart';
import 'package:smp/widgets/main_text_field.dart';
import 'package:smp/core/validation.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final bloc = GetIt.instance<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          SizedBox(height: 60.h, child: const HaveAccountOrNot(isHave: true)),
      appBar: customAppBar(context: context),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: Form(
          key: bloc.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 87.h,
              ),
              CustomLargeText(
                text: LocaleKeys.login.tr(),
                textColor: AppColors.blackText,
              ),
              SizedBox(
                height: 40.h,
              ),
              MainTextField(
                controller: bloc.email,
                hint: LocaleKeys.email.tr(),
                icon: Assets.svg.user,
                validator: (value) {
                  if (value == '') {
                    return LocaleKeys.enterEmail.tr();
                  } else if (!value!.isValidEmail) {
                    return 'bad format';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 14,
              ),
              MainTextField(
                controller: bloc.password,
                hint: LocaleKeys.password.tr(),
                icon: Assets.svg.lock,
                isPassword: true,
                validator: (value) {
                  if (value == '') {
                    return LocaleKeys.enterPassword.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: InkWell(
                  onTap: () {
                    navigateTo(context, page: Routes.forgetPassword);
                  },
                  child: CustomSmallText(
                    text: LocaleKeys.forgetPassword.tr(),
                    textColor: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              BlocListener(
                bloc: bloc,
                listener: (context, AuthStates state) {
                  if (state.status == AuthStateEnum.loaded) {
                    toast(msg: state.message!);
                    navigateTo(context,
                        page: Routes.wrapper, withHistory: false);
                  } else if (state.status == AuthStateEnum.fail) {
                    toast(msg: state.message!);
                  }
                },
                child: MainButton(
                    onTap: () {
                      if (bloc.formKey.currentState!.validate()) {
                        bloc.add(LoginEvent(
                            email: bloc.email.text.trim(),
                            password: bloc.password.text));
                      }
                    },
                    title: LocaleKeys.login.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
