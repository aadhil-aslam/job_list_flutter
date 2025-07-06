import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_lisiting/presentation/bloc/favorite_jobs/favorite_jobs_bloc.dart';
import 'package:job_lisiting/presentation/bloc/job_list/job_list_event.dart';
import 'package:job_lisiting/presentation/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/services/job_service.dart';
import 'presentation/bloc/job_list/job_list_bloc.dart';
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

class MyApp extends StatefulWidget {
  final JobServices jobServices;
  final SharedPreferences sharedPrefs;

  const MyApp({super.key, required this.jobServices, required this.sharedPrefs});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.sharedPrefs.getBool('is_dark_mode') ?? false;
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      widget.sharedPrefs.setBool('is_dark_mode', isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => JobListBloc(widget.jobServices)..add(FetchJobsEvent()),
        ),
        BlocProvider(
          create: (_) => FavoriteJobsBloc(widget.sharedPrefs),
        ),
      ],
      child: MaterialApp(
        title: 'Job Listing App',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: HomeScreen(onToggleTheme: toggleTheme),
      ),
    );
  }
}
