abstract class FavoriteJobsState {}

class FavoriteJobsInitial extends FavoriteJobsState {}

class FavoriteJobsLoaded extends FavoriteJobsState {
  final Set<String> favoriteJobIds;
  FavoriteJobsLoaded(this.favoriteJobIds);
}