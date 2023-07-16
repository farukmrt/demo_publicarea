// import 'package:demo_publicarea/providers/announcement_provider.dart';
// import 'package:flutter/material.dart';

// class CustomPagination extends StatefulWidget {
//   const CustomPagination({Key? key}) : super(key: key);

//   @override
//   State<CustomPagination> createState() => _CustomPaginationState();
// }

// class _CustomPaginationState extends State<CustomPagination> {
//   late bool _isLastPage;
//   late int _pageNumber;
//   late bool _error;
//   late bool _loading;
//   final int _numberOfPostsPerRequest = 10;
//   late List<Widget> _items;
//   final int _nextPageTrigger = 3;

//   @override
//   void initState() {
//     super.initState();
//     _pageNumber = 0;
//     _items = [];
//     _isLastPage = false;
//     _loading = true;
//     _error = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// // import 'package:flutter/material.dart';
// // import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// // class PagedListViewBuilder<T> extends StatefulWidget {
// //   final Future<List<T>> Function(int) pageFetch;
// //   final Widget Function(BuildContext, T, int) itemBuilder;
// //   final int pageSize;

// //   const PagedListViewBuilder({
// //     required this.pageFetch,
// //     required this.itemBuilder,
// //     this.pageSize = 10,
// //     Key? key,
// //   }) : super(key: key);

// //   @override
// //   _PagedListViewBuilderState<T> createState() =>
// //       _PagedListViewBuilderState<T>();
// // }

// // class _PagedListViewBuilderState<T> extends State<PagedListViewBuilder<T>> {
// //   final PagingController<int, T> _pagingController =
// //       PagingController(firstPageKey: 0);

// //   @override
// //   void initState() {
// //     super.initState();
// //     _pagingController.addPageRequestListener((pageKey) {
// //       _fetchPage(pageKey);
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return PagedListView<int, T>(
// //       pagingController: _pagingController,
// //       builderDelegate: PagedChildBuilderDelegate<T>(
// //         itemBuilder: widget.itemBuilder,
// //       ),
// //     );
// //   }

// //   Future<void> _fetchPage(int pageKey) async {
// //     try {
// //       final items = await widget.pageFetch(pageKey);
// //       final nextPageKey = items.length < widget.pageSize ? null : pageKey + 1;
// //       _pagingController.appendPage(items, nextPageKey);
// //     } catch (error) {
// //       _pagingController.error = error;
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _pagingController.dispose();
// //     super.dispose();
// //   }
// // }

// // // import 'package:flutter/material.dart';

// // // typedef ItemBuilder<T> = Widget Function(BuildContext context, T item, int index);

// // // class PagedListView<T> extends StatefulWidget {
// // //   final ItemBuilder<T> itemBuilder;
// // //   final Future<List<T>> Function(int page) pageFetcher;

// // //   const PagedListView({
// // //     Key? key,
// // //     required this.itemBuilder,
// // //     required this.pageFetcher,
// // //   }) : super(key: key);

// // //   @override
// // //   _PagedListViewState<T> createState() => _PagedListViewState<T>();
// // // }

// // // class _PagedListViewState<T> extends State<PagedListView<T>> {
// // //   static const int _pageSize = 5;
// // //   late List<T> _items;
// // //   bool _hasMore = true;
// // //   bool _isLoading = false;
// // //   int _currentPage = 0;

// // //   final ScrollController _scrollController = ScrollController();

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _items = [];
// // //     _loadNextPage();
// // //     _scrollController.addListener(_scrollListener);
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _scrollController.dispose();
// // //     super.dispose();
// // //   }

// // //   void _scrollListener() {
// // //     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
// // //       _loadNextPage();
// // //     }
// // //   }

// // //   Future<void> _loadNextPage() async {
// // //     if (!_hasMore || _isLoading) return;

// // //     setState(() {
// // //       _isLoading = true;
// // //     });

// // //     final newItems = await widget.pageFetcher(_currentPage);
// // //     setState(() {
// // //       _items.addAll(newItems);
// // //       _currentPage++;
// // //       _isLoading = false;
// // //       _hasMore = newItems.length == _pageSize;
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return ListView.builder(
// // //       controller: _scrollController,
// // //       itemCount: _items.length + (_hasMore ? 1 : 0),
// // //       itemBuilder: (context, index) {
// // //         if (index < _items.length) {
// // //           return widget.itemBuilder(context, _items[index], index);
// // //         } else {
// // //           if (_hasMore) {
// // //             return Padding(
// // //               padding: const EdgeInsets.all(8.0),
// // //               child: Center(child: CircularProgressIndicator()),
// // //             );
// // //           } else {
// // //             return Container(); // Placeholder widget when there are no more items
// // //           }
// // //         }
// // //       },
// // //     );
// // //   }
// // // }

// class PostsOverviewScreen extends StatefulWidget {

//   @override
//   _PostsOverviewScreenState createState() => _PostsOverviewScreenState();
// }
// class _PostsOverviewScreenState extends State<PostsOverviewScreen> {
//   late bool _isLastPage;
//   late int _pageNumber;
//   late bool _error;
//   late bool _loading;
//   final int _numberOfPostsPerRequest = 10;
//   late List<Widget> _listdata;
//   final int _nextPageTrigger = 3;

//   @override
//   void initState() {
//     super.initState();
//     _pageNumber = 0;
//     _listdata = [];
//     _isLastPage = false;
//     _loading = true;
//     _error = false;
//     fetchannouncements();
//   }

// }