import 'package:flutter/cupertino.dart';
import 'package:learn_git_admin/model/content_model.dart';
import '../services/ContentService.dart';

class ContentProvider extends ChangeNotifier {
  final Set<ContentModel> _contents = {};

  Set<ContentModel> get contents => _contents;

  ContentProvider() {
    getContents();
  }

  void getContents() async {
    final content = await APIService.getContent();
    _contents.addAll(content!);
    notifyListeners();
  }
}
