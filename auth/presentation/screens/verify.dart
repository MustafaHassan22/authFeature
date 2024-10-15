import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smp/core/helper_methods.dart';
import 'package:smp/core/shared_pref.dart';
import 'package:smp/core/styles.dart';
import 'package:smp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smp/gen/assets.gen.dart';
import 'package:smp/generated/locale_keys.g.dart';
import 'package:smp/routes/app_routes.dart';
import 'package:smp/widgets/main_button.dart';

class VerifyArg {
  final bool isRegister;
  final String email;

  const VerifyArg({required this.isRegister, required this.email});
}

class VerifyScreen extends StatefulWidget {
  const VerifyScreen(
      {super.key, required this.isRegister, required this.email});

  final String email;
  final bool isRegister;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final bloc = GetIt.instance<AuthBloc>();
  final bloc3 = GetIt.instance<AuthBloc>();
  final bloc2 = GetIt.instance<AuthBloc>()..add(CountDownEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              SharedPrefs.getLang() == 'en'
                  ? Assets.svg.leftArrow
                  : Assets.svg.rightArrow,
              fit: BoxFit.none,
            )),
        toolbarHeight: 54,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: BlocListener(
          bloc: bloc3,
          listener: (context,AuthStates state) {
            if(state.status==AuthStateEnum.loaded){
              toast(msg: state.message!);
            }else if(state.status==AuthStateEnum.fail){
              toast(msg: state.message!);
            }
          },
          child: Form(
            key: bloc.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 87,
                ),
                Text(
                  LocaleKeys.verifyOtp.tr(),
                  style: MyTextStyle.black28Medium,
                ),
                Text('${LocaleKeys.enterOtp.tr()}\n${widget.email}',
                    style: MyTextStyle.black14Regular,
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 36,
                ),
                PinCodeTextField(
                  controller: bloc.otp,
                  validator: (value) {
                    if (value == '' || value!.length != 6) {
                      return LocaleKeys.enterVerifyCode.tr();
                    }
                    return null;
                  },
                  appContext: context,
                  length: 6,
                  cursorHeight: 63,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  pinTheme: PinTheme(
                    borderRadius: BorderRadius.circular(16),
                    selectedBorderWidth: 2,
                    shape: PinCodeFieldShape.box,
                    inactiveFillColor: Colors.white,
                    inactiveColor: AppColors.primary,
                    selectedColor: AppColors.primary,
                    activeColor: AppColors.primary,
                    fieldHeight: 63,
                    fieldWidth: 50,
                    inactiveBorderWidth: 2,
                    activeBorderWidth: 2,
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
                      if (widget.isRegister) {
                        navigateTo(context,
                            page: Routes.login, withHistory: false);
                      } else {
                        navigateAndReplace(context, page: Routes.resetPassword);
                      }
                    } else if (state.status == AuthStateEnum.fail) {
                      toast(msg: state.message!);
                    }
                  },
                  child: MainButton(
                      onTap: () {
                        if (bloc.formKey.currentState!.validate()) {
                          bloc.add(VerifyEvent(otp: bloc.otp.text));
                        }
                      },
                      title: LocaleKeys.verify.tr()),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${LocaleKeys.didNotReceiveCode.tr()}  ',
                        style: MyTextStyle.black14Regular,
                      ),
                      BlocBuilder(
                        bloc: bloc2,
                        builder: (context, AuthStates state) {
                          return GestureDetector(
                            onTap: () {
                              if (state.status == AuthStateEnum.loaded) {
                                bloc3.add(ResendCodeEvent(email: widget.email));
                                bloc2.add(CountDownEvent());
                              }
                            },
                            child: Text(
                              '${LocaleKeys.resend.tr()}${state.status == AuthStateEnum.loading ? ' (${state.timer}s)' : ''}',
                              style: state.status == AuthStateEnum.loaded
                                  ? MyTextStyle.primary14Medium
                                  : MyTextStyle.grey14Bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
