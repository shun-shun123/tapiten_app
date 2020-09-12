import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/my_home/model/page_controller_model.dart';

class PageControllerViewModel extends ChangeNotifier {
  final PageControllerModel _pageControllerModel = PageControllerModel();

  // 現在のページインデックスの取得
  int get pageIndex => _pageControllerModel.pageIndex;

  // ページインデックスの変更
  void changePageIndex(int index) {
    _pageControllerModel.pageIndex = index;
    notifyListeners();
  }
}
