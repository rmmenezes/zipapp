import 'package:flutter/material.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/util/colors.dart';
import 'package:zipcursos_app/view/widgets/studentCard.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// ignore: must_be_immutable
class ListStudentsRankingCardsRow extends StatefulWidget {
  List<StudentModel> items = [];
  ListStudentsRankingCardsRow({Key? key, required this.items})
      : super(key: key);

  @override
  _ListStudentsRankingCardsRowState createState() =>
      _ListStudentsRankingCardsRowState();
}

class _ListStudentsRankingCardsRowState
    extends State<ListStudentsRankingCardsRow> {
  final int _pageSize = 20;
  final PagingController<int, StudentModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = widget.items;
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PagedListView<int, StudentModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<StudentModel>(
          itemBuilder: (context, item, index) => StudentCardRow(
              podiumPosition: index + 1,
              student: item,
              colorPodium: index == 0
                  ? CustomColors().colorGold
                  : index == 1
                      ? CustomColors().colorBronze
                      : index == 2
                          ? CustomColors().colorSilver
                          : CustomColors().colorGray),
        ),
      ),
    );
  }
}
