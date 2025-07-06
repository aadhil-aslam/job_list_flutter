abstract class FavoriteJobsEvent {}

class LoadFavoriteJobs extends FavoriteJobsEvent {}

class ToggleFavoriteJob extends FavoriteJobsEvent {
  final String jobId;
  ToggleFavoriteJob(this.jobId);
}