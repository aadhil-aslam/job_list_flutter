import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_lisiting/presentation/bloc/favorite_jobs/favorite_jobs_bloc.dart';
import 'package:job_lisiting/presentation/bloc/favorite_jobs/favorite_jobs_state.dart';
import 'package:job_lisiting/presentation/bloc/job_list/job_list_bloc.dart';
import 'package:job_lisiting/presentation/bloc/job_list/job_list_event.dart';
import 'package:job_lisiting/presentation/bloc/job_list/job_list_state.dart';
import '../widgets/job_card.dart';

class FavoriteJobsScreen extends StatelessWidget {
  const FavoriteJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Favorite Jobs"),
      //   backgroundColor: Colors.lightBlueAccent,
      // ),
      body: BlocBuilder<FavoriteJobsBloc, FavoriteJobsState>(
        builder: (context, favState) {
          if (favState is FavoriteJobsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (favState is! FavoriteJobsLoaded) {
            return const Center(
              child: Text(
                "Failed to load favorite jobs.",
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          return BlocBuilder<JobListBloc, JobListState>(
            builder: (context, jobState) {
              if (jobState is JobListError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Failed to load job list.", style: TextStyle(color: Colors.red)),
                      const SizedBox(height: 10),
                      Text(jobState.message, style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context.read<JobListBloc>().add(FetchJobsEvent());
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              }

              if (jobState is JobListLoading || jobState is JobListInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (jobState is JobListLoaded) {
                final favoriteJobs = jobState.jobs
                    .where((job) => favState.favoriteJobIds.contains(job.id))
                    .toList();

                if (favoriteJobs.isEmpty) {
                  return const Center(child: Text("No favorite jobs yet."));
                }

                return ListView.separated(
                  itemCount: favoriteJobs.length,
                  itemBuilder: (context, index) =>
                      JobCard(job: favoriteJobs[index]),
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}