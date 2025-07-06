import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_lisiting/presentation/bloc/favorite_jobs/favorite_jobs_bloc.dart';
import 'package:job_lisiting/presentation/bloc/job_list/job_list_event.dart';
import 'package:job_lisiting/presentation/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/services/job_service.dart';
import 'presentation/bloc/job_list/job_list_bloc.dart';
// import 'core/theme.dart';
import 'presentation/screens/job_list_screen.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final jobServices = JobServices(http.Client());
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    jobServices: jobServices,
    sharedPrefs: sharedPrefs,
  ));
}

class MyApp extends StatelessWidget {
  final JobServices jobServices;
  final SharedPreferences sharedPrefs;

  const MyApp({Key? key, required this.jobServices, required this.sharedPrefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => JobListBloc(jobServices)..add(FetchJobsEvent()),
        ),
        BlocProvider(
          create: (_) => FavoriteJobsBloc(sharedPrefs),
        ),
      ],
      child: MaterialApp(
        title: 'Job Listing App',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}
