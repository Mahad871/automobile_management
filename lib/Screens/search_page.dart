import 'package:automobile_management/Common/constants.dart';
import 'package:automobile_management/Screens/chat_list_page.dart';
import 'package:automobile_management/Screens/notificastion_page.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.title});
  final String title;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: textColor,
          toolbarHeight: 70,
          shadowColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: const CircleBorder(),
                          fixedSize: const Size.fromRadius(22),
                          side: const BorderSide(style: BorderStyle.solid)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ChatListScreen(),
                        ));
                      },
                      child: const Icon(Icons.chat_rounded)),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: const CircleBorder(),
                          fixedSize: const Size.fromRadius(22),
                          side: const BorderSide(style: BorderStyle.solid)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ));
                      },
                      child: const Icon(Icons.notifications)),
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: '  Search',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 45),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          fixedSize: const Size.fromRadius(25),
                          shape: const CircleBorder(),
                          side: const BorderSide(style: BorderStyle.solid)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ));
                      },
                      child: const Icon(Icons.mic)),
                ),
              ],
            ),
          ],
        )));
  }
}
