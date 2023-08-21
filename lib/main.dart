import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:world_famous_landmarks/bloc/auth/auth_bloc.dart';
import 'package:world_famous_landmarks/bloc/landmarks/landmarks_bloc.dart';
import 'package:world_famous_landmarks/ui/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
          BlocProvider<LandmarksBloc>(create: (context) => LandmarksBloc())
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (context, child) => const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
          ),
        ));
  }
}
