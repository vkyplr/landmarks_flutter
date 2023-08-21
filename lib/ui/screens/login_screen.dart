import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:world_famous_landmarks/bloc/auth/auth_bloc.dart';
import 'package:world_famous_landmarks/res/colors/app_colors.dart';
import 'package:world_famous_landmarks/res/dimensions/app_dimensions.dart';
import 'package:world_famous_landmarks/res/styles/text_styles.dart';
import 'package:world_famous_landmarks/ui/screens/home_screen.dart';
import 'package:world_famous_landmarks/ui/widgets/email_text_field.dart';
import 'package:world_famous_landmarks/ui/widgets/loader.dart';
import 'package:world_famous_landmarks/ui/widgets/password_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    context.read<AuthBloc>().add(AuthCheckLoginEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        body: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (previous, current) => current is AuthActionState,
          buildWhen: (previous, current) => current is! AuthActionState,
          listener: (context, state) {
            if (state is AuthSuccessNavigateToHome) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            }
          },
          builder: (context, state) {
            return state is AuthLoadingState
                ? const Loader()
                : SingleChildScrollView(
                    reverse: true,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPageHorizontalPadding,
                          vertical: kPageVerticalPadding),
                      child: Column(children: [
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 25.h,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (previous, current) =>
                              current is AuthErrorState ||
                              current is AuthValidationState,
                          builder: (context, state) {
                            return state is AuthErrorState
                                ? Text(
                                    'Invalid Email or Password',
                                    style: TextStyles.bodyMedium()
                                        .copyWith(color: kRedColor),
                                  )
                                : const SizedBox();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (previous, current) =>
                              current is AuthValidationState,
                          builder: (context, state) {
                            return EmailTextField(
                              onChange: (v) {
                                context.read<AuthBloc>().add(
                                    AuthTextChangedEvent(
                                        password: passwordController.text,
                                        email: emailController.text));
                              },
                              controller: emailController,
                              errorMessage: state is AuthValidationState &&
                                      state.isValidEmail
                                  ? null
                                  : 'Invalid Email',
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (previous, current) =>
                              current is AuthValidationState,
                          builder: (context, state) {
                            return PasswordTextField(
                              onChange: (v) {
                                context.read<AuthBloc>().add(
                                    AuthTextChangedEvent(
                                        password: passwordController.text,
                                        email: emailController.text));
                              },
                              controller: passwordController,
                              errorMessage: state is AuthValidationState &&
                                      state.isValidPassword
                                  ? null
                                  : 'Invalid Password',
                            );
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (previous, current) =>
                              current is AuthValidationState,
                          builder: (context, state) {
                            return InkWell(
                              onTap: (state is AuthValidationState &&
                                      state.isValidEmail &&
                                      state.isValidPassword)
                                  ? () {
                                      context.read<AuthBloc>().add(
                                          AuthSubmitEvent(
                                              password: passwordController.text,
                                              email: emailController.text));
                                    }
                                  : () {},
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: (state is AuthValidationState &&
                                          state.isValidEmail &&
                                          state.isValidPassword)
                                      ? kBlackColor
                                      : kBlackColor.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyles.bodyLargeBold()
                                        .copyWith(color: kWhiteColor),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ]),
                    ),
                  );
          },
        ));
  }
}
