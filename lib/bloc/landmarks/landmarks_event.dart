part of 'landmarks_bloc.dart';

@immutable
sealed class LandmarksEvent {}

// Event for Getting Landmarks List from Data Source (Example: Network Call)
class LandmarksFetchListEvent extends LandmarksEvent {}

// Event for Getting Landmark by id from Data Source (Example: Network Call)
class LandmarksFetchByIdEvent extends LandmarksEvent {
  final int id;

  LandmarksFetchByIdEvent(this.id);
}

// Event for Searching Landmark(s)
class LandmarksSearchByTextEvent extends LandmarksEvent {
  final String searchText;

  LandmarksSearchByTextEvent({required this.searchText});
}

// Event for Navigating to Landmark Info Page
class LandmarksClickLandmarkTileEvent extends LandmarksEvent {
  final Landmark landmark;

  LandmarksClickLandmarkTileEvent({required this.landmark});
}
