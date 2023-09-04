class QuizModel {
  var id;
  var score;
  var name;
  var free;
  var category;
  var level;
  var questions;

  QuizModel({id, score, name, free, category, level, questions});

  // QuizModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['theme']['name'];
  //   score = json['score'];
  //   questions = json['questions'];
  //   free = json['theme']['free'];
  //   level = json['theme']['level_id'];
  //   category = json['theme']['category_id'];
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'score': score,
  //     'free': free,
  //     'level': level,
  //     'category': category,
  //     'questions': questions
  //   };
  // }
  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return new QuizModel(
      id: json['id'],
      name:json['name'],
      score: json['score'],
      questions:json['questions'].toString(),
      free: json['free'],
      level: json['level_id'],
      category: json['category_id'],
    );
  }
}

class QuizList {
  final List<QuizModel> quizzes;
  QuizList({required this.quizzes});

  factory QuizList.fromJson(List<dynamic> parsedJson) {

    List<QuizModel> quizzes = <QuizModel>[];
    quizzes = parsedJson.map((i)=>QuizModel.fromJson(i)).toList();
    return new QuizList(
       quizzes: quizzes,
    );
  }
}
