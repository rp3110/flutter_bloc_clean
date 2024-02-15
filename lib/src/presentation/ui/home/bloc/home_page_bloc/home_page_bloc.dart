import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/model_demo_api.dart';
import '../../../../../data/repositories/repository_demo_api.dart';
import '../../../../../utils/app_validation_message.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

/// Notifies the [HomePageApiBloc] of a new [HomePageApiEvent] which triggers
/// [RepositoryHomePageApi] This class used to API and bloc connection.
/// [ApiProvider] class is used to network API call.
class HomePageApiBloc extends Bloc<HomePageApiEvent, HomePageApiState> {
  HomePageApiBloc() : super(HomePageApiInitial()) {
    on<HomePageApiUser>(_onHomePageApiNewUser);
  }

  /// Notifies the [_onHomePageApiNewUser] of a new [HomePageApiUser] which triggers
  void _onHomePageApiNewUser(
    HomePageApiUser event,
    Emitter<HomePageApiState> emit,
  ) async {
    emit(HomePageApiLoading());
    try {
      RepositoryDemoApi repositoryDemoApi = RepositoryDemoApi();
      List<ModelDemoApi?>? modelDemoApiData;

      await repositoryDemoApi.callGetMethod(event.url).then((response) {
          modelDemoApiData = List<ModelDemoApi>.from(
              response.map((model) => ModelDemoApi.fromJson(model)));
      });

      if (modelDemoApiData != null) {
        emit(HomePageApiResponse(modelDemoApiData: modelDemoApiData));
      } else {
        emit(const HomePageApiFailure(
            mError: AppValidationMessage.validationSomethingWentWrong));
      }
    } on SocketException {
      emit(const HomePageApiFailure(mError: AppValidationMessage.validationNoInternet));
    } catch (e) {
      emit(const HomePageApiFailure(
          mError: AppValidationMessage.validationInternalServerIssue));
    }
  }
}
