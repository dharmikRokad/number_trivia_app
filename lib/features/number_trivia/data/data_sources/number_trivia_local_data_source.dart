import 'dart:convert';
import 'dart:developer';
import 'package:number_trivia_app/core/app/shared_prefs.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumbersTriviaDataSourceLocal {
  Future<NumberTriviaModel> getLastTrivia();
  Future<void> addTriviaToCache(NumberTriviaModel trivia);
}

class NumbersTriviaDataSourceLocalImpl implements NumbersTriviaDataSourceLocal {
  @override
  Future<void> addTriviaToCache(NumberTriviaModel trivia) async {
    try {
      SharedPrefs.instance.addTrivia(triviaString: jsonEncode(trivia.toJson()));
    } catch (e) {
      log('error while saving trivia to local: $e');
    }
  }

  @override
  Future<NumberTriviaModel> getLastTrivia() async {
    final resp = SharedPrefs.instance.chachedTrivia;
    final model = NumberTriviaModel.fromJson(jsonDecode(resp ?? ''));
    return model;
  }
}
