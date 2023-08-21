import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: 200.h,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            if (state is AuthErrorState)
                              Text(
                                'Incorrect Email or Password',
                                style: TextStyles.bodyMedium()
                                    .copyWith(color: kRedColor),
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            EmailTextField(
                              onChange: (v) {},
                              controller: emailController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PasswordTextField(
                              onChange: (v) {},
                              controller: passwordController,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                context.read<AuthBloc>().add(AuthSubmitEvent(
                                    password: passwordController.text,
                                    email: emailController.text));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: kBlackColor,
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
                            )
                          ]),
                    ),
                  );
          },
        ));
  }
}
