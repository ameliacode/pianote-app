import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryProvider extends ChangeNotifier {
  SharedPreferences? _prefsInstance;

  static const String _recentFileKey = 'recent_file';
  static const String _recentFilesKey = 'recent_files';
  static const String _recentSearchKey = 'recent_search';

  String _recentFile = '';
  List<String> _recentFiles = [];
  List<String> _recentSearch = [];

  HistoryProvider() {
    loadHistory();
    // _init();
  }

  String get recentFile => _recentFile;
  List<String> get recentFiles => _recentFiles;
  List<String> get recentSearch => _recentSearch;

  Future<void> _init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    //getIt.signalReady(this);
  }

  // this can be deprecated
  Future<void> loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _recentFile = prefs.getString(_recentFileKey) ?? '';
    _recentFiles = prefs.getStringList(_recentFilesKey) ?? [];
    _recentSearch = prefs.getStringList(_recentSearchKey) ?? [];
    notifyListeners();
  }

  // for single string path
  Future<String> getRecentFile() async {
    return _prefsInstance?.getString(_recentFileKey) ?? '';
  }

  Future<void> setRecentFile(String filePath) async {
    _prefsInstance?.setString(_recentFileKey, filePath);
    _recentFile = filePath;
    notifyListeners();
  }

  // for multiple string paths
  Future<List<String>> getRecentFiles() async {
    return _prefsInstance?.getStringList(_recentFilesKey) ?? [];
  }

  Future<void> addRecentFile(String filePath) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!_recentFiles.contains(filePath)) {
      _recentFiles.insert(0, filePath);
      if (_recentFiles.length > 10) {
        _recentFiles.removeLast();
      }
      await _prefsInstance?.setStringList(_recentFilesKey, _recentFiles);
      notifyListeners();
    }
  }

  Future<void> removeRecentFile(String filePath) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_recentFiles.contains(filePath)) {
      _recentFiles.removeWhere((item) => item == filePath);
      await _prefsInstance?.setStringList(_recentFilesKey, _recentFiles);
      notifyListeners();
    } 
  }

  // for multiple recent search paths
  Future<List<String>> getRecentSearch() async {
    return _prefsInstance?.getStringList(_recentSearchKey) ?? [];
  }

  Future<void> addRecentSearch(String query) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!_recentSearch.contains(query)) {
      _recentSearch.insert(0, query);
      await _prefsInstance?.setStringList(_recentSearchKey, _recentSearch);
      notifyListeners();
    }
  }

  Future<void> removeAllRecentSearch() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_recentSearch.isNotEmpty) { _recentSearch.clear(); }
    notifyListeners();
  }
}

