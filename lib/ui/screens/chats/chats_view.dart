import 'package:flutter/material.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Isabirye Alex'),
        actions: [Icon(Icons.more_vert)],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return SizedBox();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
