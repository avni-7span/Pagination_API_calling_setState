import 'package:flutter/material.dart';
import 'package:pagination_example/pagination_with_set_state/api_client.dart';
import 'package:pagination_example/pagination_with_set_state/user_model.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<UserData> _userDataList = [];
  final _scrollController = ScrollController();
  int _currentPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
    getUserData(_currentPage);
  }

  Future<void> getUserData(int pageNumber) async {
    final List<UserData>? data = await ApiClient().callApi(pageNumber);
    if (data != null) {
      setState(() {
        _userDataList.addAll(data);
      });
    }
  }

  void _loadMore() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      setState(() {
        isLoading = true;
      });
      await getUserData(_currentPage);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: isLoading ? _userDataList.length + 1 : _userDataList.length,
        itemBuilder: (context, index) {
          if (index < _userDataList.length) {
            return ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage(_userDataList[index].picture?.thumbnail ?? ''),
              ),
              title: Text(
                '${_userDataList[index].name?.title ?? ''} ${_userDataList[index].name?.first ?? ''} ${_userDataList[index].name?.last ?? ''}',
              ),
              subtitle: Text(_userDataList[index].email ?? ''),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
