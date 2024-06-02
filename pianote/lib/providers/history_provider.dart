import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryProvider extends ChangeNotifier {
  static const String _recentFilesKey = 'recent_files';
  static const String _recentSearchKey = 'recent_search';
  List<String> _recentFiles = [];

  HistoryProvider() {
    loadRecentFiles();
  }

  List<String> get recentFiles => _recentFiles;

  Future<void> loadRecentFiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _recentFiles = prefs.getStringList(_recentFilesKey) ?? [];
    print(_recentFiles);
    notifyListeners();
  }

  Future<void> addRecentFile(String filePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!_recentFiles.contains(filePath)) {
      _recentFiles.insert(0, filePath);
      if (_recentFiles.length > 5) {
        _recentFiles.removeLast();
      }
      await prefs.setStringList(_recentFilesKey, _recentFiles);
      print(_recentFiles);
      notifyListeners();
    }
  }

  Future<void> removeRecentFile(String filePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_recentFiles.contains(filePath)) {
      _recentFiles.removeWhere((item) => item == filePath);
      await prefs.setStringList(_recentFilesKey, _recentFiles);
      print(_recentFiles);
      notifyListeners();
    }
  }
}
