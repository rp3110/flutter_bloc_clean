part of 'home_page_bloc.dart';

/// [HomePageApiState] abstract class is used HomePageApi State
abstract class HomePageApiState extends Equatable {
  const HomePageApiState();

  @override
  List<Object> get props => [];
}

/// [HomePageApiInitial] class is used HomePageApi State Initial
class HomePageApiInitial extends HomePageApiState {}

/// [HomePageApiLoading] class is used HomePageApi State Loading
class HomePageApiLoading extends HomePageApiState {}

/// [HomePageApiResponse] class is used HomePageApi State Response
class HomePageApiResponse extends HomePageApiState {
  final List<ModelDemoApi?>? modelDemoApiData;

  const HomePageApiResponse({
    required this.modelDemoApiData,
  });

  @override
  List<Object> get props => [];
}

/// [HomePageApiFailure] class is used HomePageApi State Failure
class HomePageApiFailure extends HomePageApiState {
  final String mError;

  const HomePageApiFailure({required this.mError});

  @override
  List<Object> get props => [mError];
}
