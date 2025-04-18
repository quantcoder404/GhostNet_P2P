






import 'package:flutter/material.dart';
import 'chat_page.dart';

class RecentChatsPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const RecentChatsPage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<RecentChatsPage> createState() => _RecentChatsPageState();
}

class _RecentChatsPageState extends State<RecentChatsPage> {
  List<Map<String, dynamic>> chats = [
    {
      'name': 'Node 1',
      'message': 'Hey there!',
      'time': '10:00 AM',
      'unread': 2,
      'avatar': 'assets/node1.png'
    },
    {
      'name': 'Node 2',
      'message': 'What\'s up?',
      'time': '9:30 AM',
      'unread': 1,
      'avatar': 'assets/node2.png'
    },
    {
      'name': 'Node 3',
      'message': 'Good morning!',
      'time': 'Yesterday',
      'unread': 0,
      'avatar': 'assets/node3.png'
    },
  ];

  List<Map<String, dynamic>> filteredChats = [];

  @override
  void initState() {
    super.initState();
    filteredChats = chats;
  }

  void filterChats(String query) {
    setState(() {
      filteredChats = chats
          .where((chat) =>
              chat['name'].toLowerCase().contains(query.toLowerCase()) ||
              chat['message'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.greenAccent,
        title: Text(
          'GhostNet',
          style: TextStyle(
            color: widget.isDarkMode ? Colors.white : Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
             icon: Icon(
                          widget.isDarkMode ? Icons.dark_mode : Icons.wb_sunny,
                       ),
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                    tooltip: widget.isDarkMode ? 'Dark Mode' : 'Light Mode',
                    onPressed: widget.toggleTheme,
                     ),
          IconButton(
            icon: const Icon(Icons.add, size: 30),
            color: widget.isDarkMode ? Colors.white : Colors.black,
            onPressed: () => addNewChat(context),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 30),
            color: widget.isDarkMode ? Colors.white : Colors.black,
            onPressed: () => showSettingsMenu(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: TextField(
              onChanged: filterChats,
              style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle:
                    TextStyle(color: widget.isDarkMode ? Colors.grey : Colors.black54),
                prefixIcon: Icon(Icons.search,
                    color: widget.isDarkMode ? Colors.grey : Colors.black54),
                filled: true,
                fillColor: widget.isDarkMode ? Colors.grey[900] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredChats.length,
              itemBuilder: (context, index) {
                final chat = filteredChats[index];
                return ListTile(
                  onTap: () {
                    // 👇 Navigate to ChatPage with arguments
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          nodeName: chat['name'],
                          
                          isDarkMode: widget.isDarkMode,
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(chat['avatar']),
                  ),
                  title: Text(chat['name'],
                      style: TextStyle(
                          color: widget.isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text(chat['message'],
                      style: TextStyle(
                          color: widget.isDarkMode ? Colors.grey : Colors.black87)),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(chat['time'],
                          style: TextStyle(
                              color:
                                  widget.isDarkMode ? Colors.grey : Colors.black)),
                      if (chat['unread'] > 0)
                        CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          radius: 10,
                          child: Text('${chat['unread']}',
                              style: const TextStyle(fontSize: 12, color: Colors.black)),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/departments');
        },
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.chat, color: Colors.black),
      ),
    );
  }

  void showSettingsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.settings,
                  color: widget.isDarkMode ? Colors.white : Colors.black),
              title: Text('Settings',
                  style: TextStyle(
                      color: widget.isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info,
                  color: widget.isDarkMode ? Colors.white : Colors.black),
              title: Text('About',
                  style: TextStyle(
                      color: widget.isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void addNewChat(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
          title: Text('Add New Chat',
              style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  labelText: 'Node Name',
                  labelStyle:
                      TextStyle(color: widget.isDarkMode ? Colors.grey : Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: messageController,
                style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  labelText: 'Initial Message',
                  labelStyle:
                      TextStyle(color: widget.isDarkMode ? Colors.grey : Colors.black),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child:
                  const Text('Add', style: TextStyle(color: Colors.greenAccent)),
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    messageController.text.isNotEmpty) {
                  setState(() {
                    chats.add({
                      'name': nameController.text,
                      'message': messageController.text,
                      'time': 'Now',
                      'unread': 1,
                      'avatar': 'assets/node1.png', // default avatar
                    });
                    filteredChats = chats;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
