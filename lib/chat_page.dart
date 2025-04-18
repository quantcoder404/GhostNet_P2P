import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String nodeName;
  final bool isDarkMode;

  const ChatPage({
    Key? key,
    required this.nodeName,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({
        'text': text.trim(),
        'isSentByMe': true,
        'time': TimeOfDay.now().format(context),
      });

      // Add auto-reply
      messages.add({
        'text': 'Auto-reply from ${widget.nodeName}',
        'isSentByMe': false,
        'time': TimeOfDay.now().format(context),
      });
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.teal.shade900 : Colors.green,
        iconTheme: IconThemeData(color: textColor),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple.shade100,
              child: Text(
                widget.nodeName[5], // Node 1 -> '1'
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.nodeName,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final align = msg['isSentByMe'] ? CrossAxisAlignment.end : CrossAxisAlignment.start;
                final color = msg['isSentByMe']
                    ? Colors.green.shade200
                    : Colors.grey.shade300;
                final radius = msg['isSentByMe']
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                      );

                return Column(
                  crossAxisAlignment: align,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: radius,
                      ),
                      child: Column(
                        crossAxisAlignment: align,
                        children: [
                          Text(
                            msg['text'],
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            msg['time'],
                            style: TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: isDark ? Colors.grey[850] : Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                      border: InputBorder.none,
                    ),
                    onSubmitted: sendMessage,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: isDark ? Colors.white : Colors.black),
                  onPressed: () => sendMessage(_controller.text),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
