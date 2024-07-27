part of 'location_bloc.dart';

class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationStarted extends LocationEvent {}

class LocationChanged extends LocationEvent {
  final Location position;

  const LocationChanged({required this.position});
}
