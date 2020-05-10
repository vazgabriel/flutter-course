class Repository {
  final int id;
  final String name;
  final String description;
  final int stars;
  final String url;

  Repository({this.id, this.name, this.description, this.stars, this.url});

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      stars: json['stargazers_count'],
      url: json['html_url'],
    );
  }
}
