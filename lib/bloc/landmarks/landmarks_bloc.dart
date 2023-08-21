import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:world_famous_landmarks/data/models/landmark_model.dart';
import 'package:world_famous_landmarks/data/models/landmarks_network_response_model.dart';
import 'package:world_famous_landmarks/repository/landmarks/landmarks_repo.dart';

part 'landmarks_event.dart';
part 'landmarks_state.dart';

class LandmarksBloc extends Bloc<LandmarksEvent, LandmarksState> {
  LandmarksBloc() : super(LandmarksInitial()) {
    on<LandmarksFetchListEvent>(landmarksFetchListEvent);
    on<LandmarksFetchByIdEvent>(landmarksFetchByIdEvent);
    on<LandmarksClickLandmarkTileEvent>(landmarksClickLandmarkTileEvent);
    on<LandmarksSearchByTextEvent>(landmarksSearchByTextEvent);
  }

  FutureOr<void> landmarksFetchListEvent(
      LandmarksFetchListEvent event, Emitter<LandmarksState> emit) async {
    // Emitting Loading State to Show Loader until Data is Fetched
    emit(LandmarksLoadingState());

    final dynamic response = await LandmarksRepo.getAllLandmarks();

    if (response is LandmarksNetworkResponseModel) {
      // Emitting Success State if Data Fetching is Successful
      emit(LandmarksSuccessState(landmarks: response.landmarks!));
    } else {
      // Emitting Error State if Data Fetching is Not Successful
      emit(LandmarksErrorState(errorMessage: response.message));
    }
  }

  FutureOr<void> landmarksFetchByIdEvent(
      LandmarksFetchByIdEvent event, Emitter<LandmarksState> emit) async {
    // Emitting Loading State to Show Loader until Data is Fetched
    emit(LandmarksLoadingState());

    final dynamic response = await LandmarksRepo.getLandmarkById(event.id);

    if (response is LandmarksNetworkResponseModel) {
      // Emitting Success State if Data Fetching is Successful
      emit(LandmarksSingleLandmarkSuccessState(
          landmark: response.landmarks!.first));
    } else {
      // Emitting Error State if Data Fetching is Not Successful
      emit(LandmarksErrorState(errorMessage: response.message));
    }
  }

  FutureOr<void> landmarksClickLandmarkTileEvent(
      LandmarksClickLandmarkTileEvent event, Emitter<LandmarksState> emit) {
    emit(LandmarksNavigateToLandmarkInfoState(landmark: event.landmark));
  }

  FutureOr<void> landmarksSearchByTextEvent(
      LandmarksSearchByTextEvent event, Emitter<LandmarksState> emit) async {
    // Emitting Loading State to Show Loader until Data is Fetched
    emit(LandmarksLoadingState());

    final dynamic response =
        await LandmarksRepo.getLandmarkBySearchText(event.searchText);

    if (response is LandmarksNetworkResponseModel) {
      // Emitting Success State if Data Fetching is Successful
      emit(LandmarksSuccessState(landmarks: response.landmarks!));
    } else {
      // Emitting Error State if Data Fetching is Not Successful
      emit(LandmarksErrorState(errorMessage: response.message));
    }
  }
}
