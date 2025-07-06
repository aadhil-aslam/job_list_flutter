class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String type;
  final String description;
  final String? salary;
  final String logoUrl;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.description,
    required this.logoUrl,
    this.salary,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json['id'],
        title: json['title'],
        company: json['company'],
        location: json['location'],
        type: json['type'],
        description: json['description'],
        logoUrl: json['logoUrl'],
        salary: json['salary'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'type': type,
      'description': description,
      'salary': salary,
      'logoUrl': logoUrl,
    };
  }
}
