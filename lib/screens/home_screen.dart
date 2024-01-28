import 'package:flutter/material.dart';
import 'package:hash_tags_flutter/components/add_hashtag.dart';
import 'package:hash_tags_flutter/screens/views/home_view.dart';
import 'package:hash_tags_flutter/screens/views/list_hashtag_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("HashTags"),
      ),
      body: PageView(
        controller: _pageController,
        children: const <Widget>[
          HomeView(),
          ListHashTagView()
        ],
        onPageChanged: (index){
          setState(() => _currentIndex = index);
        }
      ),
      floatingActionButton: const AddHashTagComponent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState((){
            _currentIndex = index;
          });

          _pageController.jumpToPage(_currentIndex);
        },
        items: const<BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Hashtags"
          )
        ]
        ),
    );
  }
}
