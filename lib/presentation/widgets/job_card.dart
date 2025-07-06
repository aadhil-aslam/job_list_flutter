import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_lisiting/data/models/job.dart';
import 'package:job_lisiting/presentation/bloc/favorite_jobs/favorite_jobs_bloc.dart';
import 'package:job_lisiting/presentation/bloc/favorite_jobs/favorite_jobs_event.dart';
import 'package:job_lisiting/presentation/bloc/favorite_jobs/favorite_jobs_state.dart';
import 'package:job_lisiting/presentation/screens/job_detail_screen.dart';

class JobCard extends StatefulWidget {
  final Job job;

  const JobCard({super.key, required this.job});

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'job-${widget.job.id}',
      child: Material(
        color: Colors.transparent,
        child: ListTile(
        title: Text(widget.job.title, style: TextStyle(fontSize: 16),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  // height: 28.0,
                  // width: 30.0,
                  child: Icon(Icons.location_city, color: Colors.teal),
                ),
                Text(
                  widget.job.company,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 8),
                // Icon(icon, size: 20, color: Colors.teal)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40.0,),
                SizedBox(
                  // height: 28.0,
                  // width: 30.0,
                  child: Icon(Icons.location_on, color: Colors.teal),
                ),
                Text(
                  widget.job.location,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 8),
                // Icon(icon, size: 20, color: Colors.teal)
              ],
            ),
          ],
        ),
        
        // Text('${widget.job.company} - ${widget.job.location}'),
        trailing: BlocBuilder<FavoriteJobsBloc, FavoriteJobsState>(
          builder: (context, state) {
            final isFavorited = state is FavoriteJobsLoaded &&
                state.favoriteJobIds.contains(widget.job.id);

            return IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(isFavorited),
                  color: isFavorited ? Colors.red : null,
                ),
              ),
              onPressed: () {
                context.read<FavoriteJobsBloc>().add(ToggleFavoriteJob(widget.job.id));
              },
            );
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => JobDetailScreen(job: widget.job)));
        },
      ),
    ));
  }
}
