import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_famous_landmarks/bloc/auth/auth_bloc.dart';
import 'package:world_famous_landmarks/bloc/landmarks/landmarks_bloc.dart';
import 'package:world_famous_landmarks/data/models/landmark_model.dart';
import 'package:world_famous_landmarks/res/colors/app_colors.dart';
import 'package:world_famous_landmarks/res/dimensions/app_dimensions.dart';
import 'package:world_famous_landmarks/res/styles/text_styles.dart';
import 'package:world_famous_landmarks/ui/screens/landmark_info_screen.dart';
import 'package:world_famous_landmarks/ui/screens/login_screen.dart';
import 'package:world_famous_landmarks/ui/widgets/error_widget.dart';
import 'package:world_famous_landmarks/ui/widgets/landmark_list_tile.dart';
import 'package:world_famous_landmarks/ui/widgets/loader.dart';
import 'package:world_famous_landmarks/ui/widgets/search_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getLandmarks();
    super.initState();
  }

  void getLandmarks() {
    context.read<LandmarksBloc>().add(LandmarksFetchListEvent());
  }

  void navigatoToLandmarkInfo(Landmark landmark) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LandmarkInfoScreen(
        landmark: landmark,
      ),
    ));

    // getLandmarks();
  }

  Widget homeContent(LandmarksSuccessState successState) {
    return Column(
      children: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => current is AuthNotLoggedInState,
          listener: (context, state) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
          },
          child: Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutEvent());
              },
              child: Text('Logout',
                  style:
                      TextStyles.bodyMediumBold().copyWith(color: kRedColor)),
            ),
          ),
        ),
        // const SizedBox(
        //   height: 20,
        // ),
        SearchTextField(
          controller: searchController,
          onChange: (searchText) {
            context
                .read<LandmarksBloc>()
                .add(LandmarksSearchByTextEvent(searchText: searchText));
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: successState.landmarks.length,
              itemBuilder: (context, index) {
                return LandmarkListTile(
                  landmark: successState.landmarks[index],
                );
              }),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Padding(
        padding: const EdgeInsets.only(
            left: kPageHorizontalPadding,
            right: kPageHorizontalPadding,
            top: kPageVerticalPadding),
        child: BlocConsumer<LandmarksBloc, LandmarksState>(
          // Listener Function will Run Only When State of Actionable State is Emitted from Bloc
          listenWhen: (previous, current) => current is LandmarksActionState,

          // Builder Function will Run Only When State of Type UI Building State is Emitted from Bloc
          buildWhen: (previous, current) => current is! LandmarksActionState,

          listener: (context, state) {
            if (state is LandmarksNavigateToLandmarkInfoState) {
              LandmarksNavigateToLandmarkInfoState navigateState = state;
              navigatoToLandmarkInfo(navigateState.landmark);
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              // Success State: When API Call Returned Success with Data
              case LandmarksSuccessState:
                LandmarksSuccessState successState =
                    state as LandmarksSuccessState;
                return homeContent(successState);

              // Loading State: When API Call is made and Waiting for Response
              case LandmarksInitial:
              case LandmarksLoadingState:
                return const Loader();

              // Error State: When API Call Returned Error
              case LandmarksErrorState:
                LandmarksErrorState errorState = state as LandmarksErrorState;
                return CustomErrorWidget(message: errorState.errorMessage);
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
