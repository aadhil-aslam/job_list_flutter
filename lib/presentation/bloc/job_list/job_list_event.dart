abstract class JobListEvent {}

class FetchJobsEvent extends JobListEvent {}

class SearchJobsEvent extends JobListEvent {
  final String query;

  SearchJobsEvent(this.query);
}
