import 'package:job_lisiting/data/models/job.dart';

abstract class JobListState {}

class JobListInitial extends JobListState {}

class JobListLoading extends JobListState {}

class JobListLoaded extends JobListState {
  final List<Job> jobs;

  JobListLoaded(this.jobs);
}


class JobListError extends JobListState {
  final String message;

  JobListError(this.message);
}
