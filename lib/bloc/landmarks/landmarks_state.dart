part of 'landmarks_bloc.dart';

@immutable
sealed class LandmarksState {}

//////////// Actionable States ////////////////////
class LandmarksActionState extends LandmarksState {}

final class LandmarksNavigateToLandmarkInfoState extends LandmarksActionState {
  final Landmark landmark;

  LandmarksNavigateToLandmarkInfoState({required this.landmark});
}

///////////// UI Building States //////////////////
// Initial State
final class LandmarksInitial extends LandmarksState {}

// Loading State
final class LandmarksLoadingState extends LandmarksState {}

// Result State
final class LandmarksSuccessState extends LandmarksState {
  final List<Landmark> landmarks;

  LandmarksSuccessState({required this.landmarks});
}

// Single Landmark Info State
final class LandmarksSingleLandmarkSuccessState extends LandmarksState {
  final Landmark landmark;

  LandmarksSingleLandmarkSuccessState({required this.landmark});
}

// Error State
final class LandmarksErrorState extends LandmarksState {
  final String errorMessage;

  LandmarksErrorState({required this.errorMessage});
}
