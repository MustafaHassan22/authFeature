import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smp/core/helper_methods.dart';
import 'package:smp/core/shared_pref.dart';
import 'package:smp/core/styles.dart';
import 'package:smp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smp/features/auth/presentation/screens/verify.dart';
import 'package:smp/gen/assets.gen.dart';
import 'package:smp/generated/locale_keys.g.dart';
import 'package:smp/routes/app_routes.dart';
import 'package:smp/widgets/custom_appbar.dart';
import 'package:smp/widgets/have_account_or_not.dart';
import 'package:smp/widgets/main_button.dart';
import 'package:smp/widgets/main_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final bloc = GetIt.instance<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context),
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
                LocaleKeys.forgetPasswordWithoutQuestion.tr(),
                style: MyTextStyle.black28Medium,
              ),
              const SizedBox(
                height: 40,
              ),
              MainTextField(
                controller: bloc.email,
                hint: LocaleKeys.email.tr(),
                icon: Assets.svg.user,
                validator: (value) {
                  if (value == '') {
                    return LocaleKeys.enterEmail.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              BlocListener(
                bloc: bloc,
                listener: (context, AuthStates state) {
                  if(state.status == AuthStateEnum.loaded){
                    toast(msg: state.message!);
                    navigateTo(context, page: Routes.verify,arguments: VerifyArg(isRegister: false,email: bloc.email.text.trim()));
                  }else if(state.status == AuthStateEnum.fail){
                    toast(msg: state.message!);
                  }
                },
                child: MainButton(
                    onTap: () {
                      // SharedPrefs.clear();
                      bloc.add(ForgetPasswordEvent(email: bloc.email.text.trim()));
                    },
                    title: LocaleKeys.send.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
