import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_blog/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import '../../../../core/presentation/widgets/back_button_widget.dart';
import '../../../../core/presentation/widgets/large_button_widget.dart';
import '../../../../core/presentation/widgets/text_field_widget.dart';
import '../../../../core/presentation/widgets/toggle_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpBloc signUpBloc = BlocProvider.of<SignUpBloc>(context);
    return BlocBuilder<SignUpBloc, SignUpStates>(
      builder: (context, state) {
        if (state is SignUpStartState) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButtonWidget(
                      onTap: () {
                        context.go('/sign_in');
                      },
                    ),
                    const SizedBox(height: 43),
                    const Text('Lets get started!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Enter you information bellow', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 35),
                    TextFieldWidget(
                      labelText: 'E-mail',
                      suffixText: '',
                      onTap: () {},
                      textEditingController: state.emailController,
                      isPassword: false,
                    ),
                    const SizedBox(height: 35),
                    TextFieldWidget(
                      textEditingController: state.passwordController,
                      labelText: 'Password',
                      suffixText: '',
                      onTap: () {},
                      isPassword: true,
                    ),
                    const SizedBox(height: 35),
                    TextFieldWidget(
                      textEditingController: state.firstNameController,
                      labelText: 'First name',
                      suffixText: '',
                      onTap: () {},
                      isPassword: false,
                    ),
                    const SizedBox(height: 35),
                    TextFieldWidget(
                      textEditingController: state.secondNameController,
                      labelText: 'Second name',
                      suffixText: '',
                      onTap: () {},
                      isPassword: false,
                    ),
                    const SizedBox(height: 42),
                    Row(
                      children: const [
                        Text(
                          'I agree with the Terms of User',
                          style: TextStyle(color: Color(0xFF9F9F9F), fontSize: 18),
                        ),
                        Spacer(),
                        ToggleWidget(),
                      ],
                    ),
                    const SizedBox(height: 45),
                    LargeButtonWidget(
                      largeButtonText: 'SIGN UP',
                      onTap: () {
                        signUpBloc.add(SignUpCheckEvent(
                          context,
                          emailController: state.emailController,
                          passwordController: state.passwordController,
                          state.firstNameController,
                          state.secondNameController,
                        ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is SignUpLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return const SizedBox.shrink();
      },
    );
  }
}
