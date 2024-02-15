part of 'home_page_bloc.dart';

/// [HomePageApiEvent] abstract class is used Event of bloc.
abstract class HomePageApiEvent extends Equatable {
  const HomePageApiEvent();

  @override
  List<Object> get props => [];
}

/// [HomePageApiUser] abstract class is used HomePageApi Event
class HomePageApiUser extends HomePageApiEvent {
  final String url;

  const HomePageApiUser({required this.url});

  @override
  List<Object> get props => [];
}
