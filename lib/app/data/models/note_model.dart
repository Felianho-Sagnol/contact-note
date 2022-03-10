class NoteModel {
  final String? id;
   String title;
   String content;
  final String userUid ;
  final String? createdAt;
   String? updatedAt ;

  NoteModel({
    this.id = "",
    required this.title,
    required this.userUid,
    required this.content,
    this.createdAt = "",
    this.updatedAt ="",
  });

  factory NoteModel.fromMap(map) {
    return NoteModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      userUid: map['userUid'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title':title,
      'content': content,
      'userUid': userUid,
      'createdAt': createdAt,
      'updatedAt' : updatedAt,
    };
  }

  void update(String ptitle, String pcontent,String date) {
    title = ptitle;
    content = pcontent;
    updatedAt = date;
  }

  @override
  String toString() {
    // TODO: implement toString
    return userUid+" "+createdAt!+" " +updatedAt! + " " + title + " " + content;
  }
}
