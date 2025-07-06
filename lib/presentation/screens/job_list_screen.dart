import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_lisiting/presentation/bloc/job_list/job_list_event.dart';
import 'package:job_lisiting/presentation/bloc/job_list/job_list_state.dart';
import 'package:job_lisiting/presentation/screens/favorite_jobs_screen.dart';
import 'package:job_lisiting/presentation/screens/job_detail_screen.dart';
import 'package:job_lisiting/presentation/widgets/job_card.dart';
import '../bloc/job_list/job_list_bloc.dart';

class JobListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Jobs'),
      //   // actions: [
      //   //   IconButton(
      //   //     icon: const Icon(Icons.favorite),
      //   //     onPressed: () {
      //   //       Navigator.push(
      //   //         context,
      //   //         MaterialPageRoute(builder: (_) => const FavoriteJobsScreen()),
      //   //       );
      //   //     },
      //   //   ),
      //   // ],
      //   backgroundColor: Colors.lightBlueAccent,
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0,16.0,16.0,8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search jobs...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<JobListBloc>().add(SearchJobsEvent(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<JobListBloc, JobListState>(
              builder: (context, state) {
                if (state is JobListLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is JobListLoaded) {
                  if (state.jobs.isEmpty) {
                    return Center(child: Text('No jobs available'));
                  }
                  return ListView.separated(
                    itemCount: state.jobs.length,
                    itemBuilder: (context, index) {
                      final job = state.jobs[index];
                      return JobCard(job: job);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  );
                } else if (state is JobListError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
