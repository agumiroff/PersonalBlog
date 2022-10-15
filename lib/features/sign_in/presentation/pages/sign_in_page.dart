import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_blog/core/presentation/pages/error_page.dart';
import 'package:personal_blog/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import '../../../../core/presentation/widgets/back_button_widget.dart';
import '../../../../core/presentation/widgets/large_button_widget.dart';
import '../../../../core/presentation/widgets/text_field_widget.dart';
import '../../../../core/presentation/widgets/toggle_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    SignInBloc signInBloc = BlocProvider.of<SignInBloc>(context);
    return BlocBuilder<SignInBloc, SignInStates>(builder: (context, state) {
      if (state is SignInErrorState) {
        return const ErrorPage();
      }
      if (state is SignInStartState) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 34.h, horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  BackButtonWidget(
                    onTap: () {},
                  ),
                  SizedBox(height: 43.h),
                  Text('Welcome back!', style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w800)),
                  SizedBox(height: 8.h),
                  Text('Enter your credential to continue', style: TextStyle(fontSize: 18.sp)),
                  SizedBox(height: 110.h),
                  TextFieldWidget(
                    labelText: 'E-mail',
                    suffixText: '',
                    onTap: () {},
                    textEditingController: state.emailController,
                    isPassword: false,
                  ),
                  SizedBox(height: 35.h),
                  TextFieldWidget(
                    labelText: 'Password',
                    suffixText: 'Forget?',
                    onTap: () {
                      context.go('/sign_up');
                    },
                    textEditingController: state.passwordController,
                    isPassword: true,
                  ),
                  SizedBox(height: 35.h),
                  Row(
                    children: [
                      Text(
                        'Remember me next time',
                        style: TextStyle(color: const Color(0xFF9F9F9F), fontSize: 18.sp),
                      ),
                      const Spacer(),
                      const ToggleWidget(),
                    ],
                  ),
                  SizedBox(height: 178.h),
                  LargeButtonWidget(
                    largeButtonText: 'SIGN IN',
                    onTap: () {
                      signInBloc.add(SignInEvent(
                          emailController: state.emailController,
                          passwordController: state.passwordController,
                          context: context));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
