import 'package:flutter/material.dart';
import 'package:tapiten_app/ui/message/viewModel/message_list_cell_view_model.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page.dart';

class MessageListCell extends StatelessWidget {
  final Answer answer;
  MessageListCell({this.answer});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFE9E9E9),
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: ListTile(
          title: Text('Message1'),
          subtitle: Text('Message subtitle'),
          leading: Icon(
            Icons.account_circle,
            color: Colors.blue[500],
          ),
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return MessageDetailPage(
                answer: answer,
              );
            })),
          },
        ),
      ),
    );
  }
}
