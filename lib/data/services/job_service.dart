import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:job_lisiting/data/models/job.dart';
import 'package:job_lisiting/data/services/api_services.dart';

class JobServices{
  final http.Client client;
  final ApiService _apiServices = ApiService();

  JobServices(this.client);

  Future<List<Job>> fetchJobs() async {
    final response = await client.get(Uri.parse('${_apiServices.baseUrl}api/jobs'));
    // ('https://6868ca64d5933161d70c7025.mockapi.io/api/jobs'));

    if (response.statusCode == 200) {
      List<dynamic> jobList = json.decode(response.body);
      return jobList.map((jobData) => Job.fromJson(jobData)).toList();
    } else {
      throw Exception('Failed to load jobs: ${response.statusCode}');
    }
  }
}
