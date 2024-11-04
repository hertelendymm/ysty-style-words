class Word {
  final String wordId;
  final String germanWord;
  final String englishMeaning;
  final String hungarianMeaning;
  final String exampleSentence;
  final String article;
  final String category;

  Word({
    required this.wordId,
    required this.germanWord,
    required this.englishMeaning,
    required this.hungarianMeaning,
    required this.exampleSentence,
    required this.article,
    required this.category,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      wordId: json['wordId'],
      germanWord: json['germanWord'],
      englishMeaning: json['englishMeaning'],
      hungarianMeaning: json['hungarianMeaning'],
      exampleSentence: json['exampleSentence'],
      article: json['article'],
      category: json['category'],
    );
  }

  @override
  String toString() {
    return 'Word{wordId: $wordId, germanWord: $germanWord, englishMeaning: $englishMeaning, hungarianMeaning: $hungarianMeaning, exampleSentence: $exampleSentence, article: $article, category: $category}\n';
  }
}