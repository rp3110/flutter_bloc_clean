class ModelDemoApi {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  ModelDemoApi({this.postId, this.id, this.name, this.email, this.body});

  ModelDemoApi.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }
}
