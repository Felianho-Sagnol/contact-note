class TodoModel {
  final String? id;
  final String? content;
  final String userUid ;
  final String? createdAt;
  final String? updatedAt ;
  final String title;
  final dynamic status ; 

  TodoModel({
    this.id = "",
    this.userUid = "",
    this.title="",
    this.createdAt = "",
    this.updatedAt ="",
    this.content="",
    this.status="",
  });

  factory TodoModel.fromMap(map) {
    return TodoModel(
      id: map['id'],
      content: map['content'],
      title: map['title'],
      userUid: map['userUid'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'title' : title,
      'userUid' : userUid,
      'createdAt': createdAt,
      'updatedAt' : updatedAt,
    };
  }
}