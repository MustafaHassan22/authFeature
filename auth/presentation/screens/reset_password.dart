import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:smp/core/helper_methods.dart';
import 'package:smp/core/shared_pref.dart';
import 'package:smp/core/styles.dart';
import 'package:smp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smp/gen/assets.gen.dart';
import 'package:smp/generated/locale_keys.g.dart';
import 'package:smp/routes/app_routes.dart';
import 'package:smp/widgets/main_button.dart';
import 'package:smp/widgets/main_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final bloc = GetIt.instance<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              SharedPrefs.getLang() == 'en' ? Assets.svg.leftArrow : Assets.svg
                  .rightArrow,
              fit: BoxFit.none,
            )),
        toolbarHeight: 54,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: Form(
          key: bloc.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 87,
              ),
              Text(
                LocaleKeys.resetPassword.tr(),
                style: MyTextStyle.black28Medium,
              ),
              const SizedBox(
                height: 40,
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
                height: 14,
              ),
              MainTextField(
                controller: bloc.confirmPassword,
                hint: LocaleKeys.confirmPassword.tr(),
                icon: Assets.svg.lock,
                isPassword: true,
                validator: (value) {
                  if (value == '') {
                    return LocaleKeys.enterPassword.tr();
                  } else if (value != bloc.password.text) {
                    return LocaleKeys.passwordDoNotMatch.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              BlocListener(
                bloc: bloc,
                listener: (context,AuthStates state) {
                  if(state.status == AuthStateEnum.loaded){
                    SharedPrefs.clear();
                    toast(msg: state.message!);
                    navigateTo(context, page: Routes.login,withHistory: false);
                  }else if (state.status == AuthStateEnum.fail){
                    toast(msg: state.message!);
                  }
                },
                child: MainButton(onTap: () {
                  bloc.add(ResetPasswordEvent(password: bloc.password.text,
                      confirmPassword: bloc.confirmPassword.text));
                }, title: LocaleKeys.reset.tr()),
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
