import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

class HistoryProvider extends ChangeNotifier {
  SharedPreferences? _prefsInstance;

  static const String _recentFileKey = 'recent_file';
  static const String _recentFilesKey = 'recent_files';
  static const String _recentSearchKey = 'recent_search';

  List<String> _recentFiles = [];
  List<String> _recentSearch = [];

  HistoryProvider() {
    //loadHistory();
     _init();
  }

  String get recentFile =>  _prefsInstance?.getString(_recentFileKey) ?? '';
  List<String> get recentFiles => _prefsInstance?.getStringList(_recentFilesKey) ?? [];
  List<String> get recentSearch => _prefsInstance?.getStringList(_recentSearchKey) ?? [];

  Future<void> _init() async {
    _prefsInstance = await SharedPreferences.getInstance();
  }

  // for single string path
  Future<String> getRecentFile() async {
    return await _prefsInstance?.getString(_recentFileKey) ?? '';
  }

  Future<void> setRecentFile(String filePath) async {
    await _prefsInstance?.setString(_recentFileKey, filePath);
    print("hello");
    notifyListeners();
  }

  // for multiple string paths
  Future<List<String>> getRecentFiles() async {
    return await _prefsInstance?.getStringList(_recentFilesKey) ?? [];
  }

  Future<void> addRecentFile(String filePath) async {
    _recentFiles = _prefsInstance?.getStringList(_recentFilesKey) ?? [];
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
    _recentFiles = _prefsInstance?.getStringList(_recentFilesKey) ?? []; 
    if (_recentFiles.contains(filePath)) {
      _recentFiles.removeWhere((item) => item == filePath);
      await _prefsInstance?.setStringList(_recentFilesKey, _recentFiles);
      notifyListeners();
    } 
  }

  // for multiple recent search paths
  Future<List<String>> getRecentSearch() async {
    return await _prefsInstance?.getStringList(_recentSearchKey) ?? [];
  }

  Future<void> addRecentSearch(String query) async {
    _recentSearch = _prefsInstance?.getStringList(_recentSearchKey) ?? [];
    if (!_recentSearch.contains(query)) {
      _recentSearch.insert(0, query);
      await _prefsInstance?.setStringList(_recentSearchKey, _recentSearch);
      notifyListeners();
    }
  }

  Future<void> removeAllRecentSearch() async {
    _recentSearch = _prefsInstance?.getStringList(_recentSearchKey) ?? [];
    if (_recentSearch.isNotEmpty) { _recentSearch.clear(); }
    notifyListeners();
  }
}

