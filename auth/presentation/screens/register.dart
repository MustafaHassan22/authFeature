import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:smp/core/helper_methods.dart';
import 'package:smp/core/shared_pref.dart';
import 'package:smp/core/styles.dart';
import 'package:smp/core/widgets/custom_date_picker_widget.dart';
import 'package:smp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smp/features/auth/presentation/screens/verify.dart';
import 'package:smp/gen/assets.gen.dart';
import 'package:smp/generated/locale_keys.g.dart';
import 'package:smp/routes/app_routes.dart';
import 'package:smp/widgets/have_account_or_not.dart';
import 'package:smp/widgets/main_button.dart';
import 'package:smp/widgets/main_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final bloc = GetIt.instance<AuthBloc>();
  String dateSelect = '';
  String groupValue = 'male';
  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  void initState() {
    dateSelect = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const SizedBox(height: 60, child: HaveAccountOrNot(isHave: false)),
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
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: bloc.formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 87,
                    ),
                    Text(
                      LocaleKeys.register.tr(),
                      style: MyTextStyle.black28Medium,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    MainTextField(
                      controller: bloc.name,
                      hint: LocaleKeys.name.tr(),
                      icon: Assets.svg.user,
                      validator: (value) {
                        if (value == '') {
                          return LocaleKeys.enterUserName.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    MainTextField(
                      controller: bloc.username,
                      hint: LocaleKeys.userName.tr(),
                      icon: Assets.svg.user,
                      validator: (value) {
                        if (value == '') {
                          return LocaleKeys.enterUserName.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
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
                      height: 10,
                    ),
                    CustomDatePicker(
                      dateSelect: dateSelect,
                      onSelectAndChange: (date) {
                        setState(() {
                          dateSelect = _formatDate(date);
                        });
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                            value: 'male',
                            groupValue: groupValue,
                            onChanged: (value) {
                              setState(() {
                                groupValue = value!;
                              });
                            }),
                        Text(LocaleKeys.maleGander.tr()),
                        SizedBox(
                          width: 50.w,
                        ),
                        Radio(
                            value: 'female',
                            groupValue: groupValue,
                            onChanged: (value) {
                              setState(() {
                                groupValue = value!;
                              });
                            }),
                        Text(LocaleKeys.femaleGander.tr()),
                      ],
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
                      height: 15,
                    ),

                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       activeColor: AppColors.primary,
                    //         value: bloc.isAgree,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             bloc.isAgree = value!;
                    //           });
                    //         }),
                    //     Text(LocaleKeys.agreeToTerms.tr(),style: MyTextStyle.black14Regular,)
                    //   ],
                    // ),

                    // Spacer(),
                  ],
                ),
              ),
            ),
          ),
          BlocListener(
            bloc: bloc,
            listener: (context, AuthStates state) {
              if (state.status == AuthStateEnum.loaded) {
                toast(msg: state.message!);
                navigateTo(context,
                    page: Routes.verify,
                    arguments: VerifyArg(
                        isRegister: true, email: bloc.email.text.trim()));
              } else if (state.status == AuthStateEnum.fail) {
                toast(msg: state.message!);
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: MainButton(
                  onTap: () {
                    if (bloc.formKey.currentState!.validate()) {
                      bloc.add(RegisterEvent(
                          name: bloc.name.text.trim(),
                          userName: bloc.username.text.trim(),
                          email: bloc.email.text.trim(),
                          password: bloc.password.text));
                    }
                  },
                  title: LocaleKeys.register.tr()),
            ),
          ),
        ],
      ),
    );
  }
}
