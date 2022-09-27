import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_blog/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import '../../../../core/presentation/widgets/back_button_widget.dart';
import '../../../../core/presentation/widgets/large_button_widget.dart';
import '../../../../core/presentation/widgets/text_field_widget.dart';
import '../../../../core/presentation/widgets/toggle_widget.dart';

class SignInPage extends StatelessWidget {
  final double width = double.infinity;
  const SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    SignInBloc signInBloc = BlocProvider.of<SignInBloc>(context);
    return BlocBuilder<SignInBloc, SignInStates>(builder: (context, state) {
      if (state is SignInStartState) {
        return Material(
          child: Center(
            child: Container(
              width: width,
              padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
              decoration: const BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(color: Colors.grey),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButtonWidget(
                    onTap: () {},
                  ),
                  const Spacer(flex: 1),
                  const SizedBox(height: 43),
                  const Text('Welcome back!', style: TextStyle(fontSize: 43, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Enter your credential to continue', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 110),
                  TextFieldWidget(
                    labelText: 'E-mail',
                    suffixText: '',
                    onTap: () {},
                    textEditingController: state.emailController,
                    isPassword: false,
                  ),
                  const SizedBox(height: 35),
                  TextFieldWidget(
                    labelText: 'Password',
                    suffixText: 'Forgot?',
                    onTap: () {
                      Navigator.pushNamed(context, 'sign_up');
                    },
                    textEditingController: state.passwordController,
                    isPassword: true,
                  ),
                  const Spacer(),
                  Row(
                    children: const [
                      Text(
                        'Remember me next time',
                        style: TextStyle(color: Color(0xFF9F9F9F), fontSize: 22),
                      ),
                      Spacer(),
                      ToggleWidget(),
                    ],
                  ),
                  const Spacer(flex: 2),
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
