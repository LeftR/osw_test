part of 'location_bloc.dart';

class LocationState extends Equatable {
  late Location location;
  LocationState({
    required this.location,
  });

  factory LocationState.initial() {
    return LocationState(location: Location());
  }

  @override
  String toString() => 'LocationState(location: $location)';

  LocationState copyWith({
    Location? location,
  }) {
    return LocationState(
      location: location ?? this.location,
    );
  }

  @override
  List<Object> get props => [location];
}
