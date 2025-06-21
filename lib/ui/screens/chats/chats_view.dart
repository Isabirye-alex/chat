import 'package:flutter/material.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Isabirye Alex'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(Icons.more_vert),
          ),
        ],
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
          Positioned(bottom: 0, left: 0, right: 0, child: ChatsTextField()),
        ],
      ),
    );
  }
}

class ChatsTextField extends StatefulWidget {
  const ChatsTextField({super.key});

  @override
  State<ChatsTextField> createState() => _ChatsTextFieldState();
}

class _ChatsTextFieldState extends State<ChatsTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Colors.grey,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(),
              child: Icon(Icons.add),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(color: Colors.transparent),
              child: TextField(
                decoration: InputDecoration(
                  hint: Text('Write message'),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send),
                  ),
                  disabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.mic_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
