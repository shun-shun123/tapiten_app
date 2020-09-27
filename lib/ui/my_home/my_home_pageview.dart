import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapiten_app/ui/my_home/viewModel/page_controller_view_model.dart';
import 'package:tapiten_app/ui/profile/profile_page.dart';
import 'package:tapiten_app/view/message_list_page/message_list_view/message_list_page.dart';

class MyHomePageView extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<PageControllerViewModel>(context);

    final pageView = PageView(
      controller: _pageController,
      children: [
        MessageListPage(),
        ProfilePage(),
      ],
      physics: NeverScrollableScrollPhysics(),
    );

    if (_pageController.hasClients && viewModel.pageIndex != _pageController.page.toInt()) {
      _pageController.jumpToPage(viewModel.pageIndex);
    }
    return pageView;
  }
}
