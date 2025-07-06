import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_lisiting/data/models/job.dart';
import 'package:job_lisiting/presentation/bloc/favorite_jobs/favorite_jobs_bloc.dart';
import 'package:job_lisiting/presentation/bloc/favorite_jobs/favorite_jobs_event.dart';
import 'package:job_lisiting/presentation/bloc/favorite_jobs/favorite_jobs_state.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;

  const JobDetailScreen({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'job-${job.id}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              job.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actions: [
          BlocBuilder<FavoriteJobsBloc, FavoriteJobsState>(
            builder: (context, state) {
              final isFavorite = state is FavoriteJobsLoaded &&
                  state.favoriteJobIds.contains(job.id);

              return IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(isFavorite),
                    color: isFavorite ? Colors.red : null,
                  ),
                ),
                onPressed: () {
                  context.read<FavoriteJobsBloc>().add(ToggleFavoriteJob(job.id));
                },
              );
            },
          ),
        ],
      ),
      // Text(job.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  // height: 28.0,
                  // width: 30.0,
                  child: Icon(Icons.card_travel_outlined, color: Colors.teal),
                ),
                SizedBox(width: 8),
                Text(job.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                // Icon(icon, size: 20, color: Colors.teal)
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  // height: 28.0,
                  // width: 30.0,
                  child: Icon(Icons.location_city, color: Colors.teal),
                ),
                SizedBox(width: 8),
                Text(job.company, style: TextStyle(fontSize: 18)),
                // Icon(icon, size: 20, color: Colors.teal)
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  child: Icon(Icons.location_on, color: Colors.teal),
                ),
                SizedBox(width: 8),
                Text(job.location, style: TextStyle(fontSize: 16, color: Colors.grey)),
                // Icon(icon, size: 20, color: Colors.teal)
              ],
            ),
            // Text(job.location),
            SizedBox(height: 18),
            Text('Job Type: ${job.type}', style: TextStyle(fontSize: 17,)),
            SizedBox(height: 16),
            Text('Job Description:\n${job.description}', style: TextStyle(fontSize: 17,)),
            SizedBox(height: 16),
            if (job.salary != null) Text('Salary: ${double.parse(job.salary!) * 1000} LKR', style: TextStyle(fontSize: 17,)),
            Spacer(),
            SizedBox(
              width: double.infinity, 
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Application Sent'),
                      content: const Text('Your application has been submitted successfully.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text('OK'),
                        )
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.lightBlueAccent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Apply',
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // child: const Text('Apply'),
              )),
          ],
        ),
      ),
    );
  }
}
