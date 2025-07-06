import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_lisiting/data/services/job_service.dart';
import 'package:job_lisiting/presentation/bloc/job_list/job_list_event.dart';
import 'package:job_lisiting/presentation/bloc/job_list/job_list_state.dart';

class JobListBloc extends Bloc<JobListEvent, JobListState> {
  final JobServices jobServices;

  JobListBloc(this.jobServices) : super(JobListInitial()) {
    on<FetchJobsEvent>(_onFetchJobs);
    on<SearchJobsEvent>(_onSearchJobs);
  }

  Future<void> _onFetchJobs(FetchJobsEvent event, Emitter<JobListState> emit) async {
    emit(JobListLoading());
    try {
      final jobs = await jobServices.fetchJobs();
      // print(jobs);
      emit(JobListLoaded(jobs));
    } catch (e) {
      emit(JobListError(e.toString()));
    }
  }

  Future<void> _onSearchJobs(SearchJobsEvent event, Emitter<JobListState> emit) async {
    emit(JobListLoading());
    try {
      final jobs = await jobServices.fetchJobs();
      final filtered = jobs.where((job) =>
        job.title.toLowerCase().contains(event.query.toLowerCase()) ||
        job.location.toLowerCase().contains(event.query.toLowerCase())
      ).toList();
      emit(JobListLoaded(filtered));
    } catch (e) {
      emit(JobListError(e.toString()));
    }
  }
}
