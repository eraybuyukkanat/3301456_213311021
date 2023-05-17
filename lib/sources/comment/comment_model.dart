class commentModel {
  List<Comment>? comments;

  commentModel({this.comments});

  commentModel.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comment>[];
      json['comments'].forEach((v) {
        comments!.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  String? sId;
  String? description;
  String? email;
  int? iV;

  Comment({this.sId, this.description, this.email, this.iV});

  Comment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    email = json['email'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['email'] = this.email;
    data['__v'] = this.iV;
    return data;
  }
}
