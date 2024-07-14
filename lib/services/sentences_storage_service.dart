import 'package:hive_flutter/hive_flutter.dart';

class SentencesStorageService {
  final _boxName = "sentencesBox";
  final _sentencesKey = "sentencesKey";

  Future get _get async => await Hive.openBox(_boxName);

  Future<bool> addSentence(String newSentence) async {
    try {
      final oldSentences = await getAllSentences();

      if (oldSentences.length == 10) return false;

      var box = await Hive.openBox(_boxName);
      var finalArr = [...oldSentences, newSentence];
      await box.put(_sentencesKey, finalArr);
      await box.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateSentences(List<String> updatedSentences) async {
    try {
      var box = await Hive.openBox(_boxName);
      await box.put(_sentencesKey, updatedSentences);
      await box.close();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<String>> getAllSentences() async {
    try {
      var box = await Hive.openBox(_boxName);
      List<String> sentences = await box.get(
        _sentencesKey,
        defaultValue: [],
      );
      await box.close();
      return sentences;
    } catch (e) {
      return [];
    }
  }

  Future deleteSentence(int position) async {
    try {
      final sentences = await getAllSentences();

      sentences.removeAt(position);

      bool saved = await updateSentences(sentences);
      return saved;
    } catch (e) {
      return false;
    }
  }

  Future deleteBox() async {
    var box = await Hive.openBox(_boxName);
    box.delete(_sentencesKey);
  }
}
