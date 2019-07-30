import 'package:flutter/material.dart';
import 'package:flutter_shows/common/global.dart';
import 'package:flutter_shows/model/HomeListResponse.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecommendJob extends StatefulWidget {
  final arguments;

  RecommendJob({this.arguments});

  @override
  RecommendJobState createState() => new RecommendJobState(arguments);
}

class RecommendJobState extends State<RecommendJob> {
  final arguments;

  RecommendJobState(this.arguments);

  double screenWidth = 0;
  List<HomeListInfo> list = List<HomeListInfo>();

  int category = 0;
  int accommodation = -1;
  int urgency = -1;
  int highSalary = -1;
  int hot = -1;
  String title = '';
  String imgPath = '';

  final ScrollController _scrollController = ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    if (arguments != null) {
      category = arguments['category'] ??= 0;
      accommodation = arguments['accommodation'] ??= -1;
      hot = arguments['hot'] ??= -1;
      urgency = arguments['urgency'] ??= -1;
      highSalary = arguments['highSalary'] ??= -1;
      title = arguments['title'] ??= '';
      imgPath = arguments['imgPath'] ??= '';
    }
//    _requestHomeList();
    _scrollController.addListener(() {
//      print('offset----->${_scrollController.offset}');
//      print('initialScrollOffset----->${_scrollController.initialScrollOffset}');
      setState(() {
        if (_scrollController.offset > 100) {
          isShow = true;
        } else {
          isShow = false;
        }
      });
    });
  }

  void _requestHomeList() {
    Map<String, dynamic> param = {
      'max_age': 100,
      'max_salary': 30000,
      'min_salary': 1000,
      'lon': '121.52424',
      'lat': '31.232044',
      'page': 1,
      'category': category,
      'min_age': 16,
      'gender_require': 0,
      'page_size': 10,
    };
    if (accommodation != -1) {
      param['accommodation'] = accommodation;
    }
    if (urgency != -1) {
      param['urgency'] = urgency;
    }
    if (highSalary != -1) {
      param['high_salary'] = highSalary;
    }
    if (hot != -1) {
      param['hot'] = hot;
    }
    CommonRequest.requestJobList(params: param).then((result) {
      HomeListResponse homeListResponse = HomeListResponse.fromJson(result);
      if (homeListResponse.code == 0) {
        setState(() {
          list = homeListResponse.data.data;
        });
        _refreshController.refreshCompleted();
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = ScreenUtil.getScreenW(context);
    return Scaffold(
      body: SmartRefresher(
        enablePullUp: true,
        controller: _refreshController,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              expandedHeight: 150,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  title,
                  style: TextStyle(
                      color: isShow ? Color(0xFF232323) : Colors.transparent),
                ),
                background: Image.asset(
                  Utils.wapperResourcePath(imgPath),
                  width: double.infinity,
                  height: 150,
                ),
              ),
            ),
            _listView()
          ],
        ),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
      ),
    );
  }

  void _onRefresh() async {
    _requestHomeList();
  }

  void _onLoading() async {}

  Widget _listView() {
    return SliverStaggeredGrid.countBuilder(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        staggeredTileBuilder: (_) => StaggeredTile.fit(1),
        itemBuilder: (BuildContext context, int index) => _jobItem(list, index),
        itemCount: list.length);
  }

  Widget _ImageSize(HomeListInfo info) {
    double width = 0;
    double height = 0;
    double defaultWidth = (screenWidth - 56) / 2;
    if (info.width == 0 || info.height == 0) {
      width = defaultWidth;
      height = width;
    } else {
      double scale = defaultWidth / info.width;
      width = defaultWidth;
      height = scale * info.height;
    }
    return ClipRRect(
      child: Image.network(
        info.job_img,
        width: width.toDouble(),
        height: height.toDouble(),
        fit: BoxFit.fill,
      ),
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  Widget _jobItem(List<HomeListInfo> list, int index) {
    if (list == null && list.length == 0) {
      return Container();
    }
    return Card(
      elevation: 2,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                _ImageSize(list[index]),
                Positioned(
                  child: Text(
                    '陆家嘴',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  left: 8,
                  bottom: 5,
                ),
                Positioned(
                  child: Text(
                    list[index].distance,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  right: 8,
                  bottom: 5,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                list[index].in_a_word,
                style: TextStyle(color: Color(0xFF232323), fontSize: 13),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(list[index].salary + list[index].salary_unit,
                  style: TextStyle(color: Color(0xFFFF4443), fontSize: 14)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22.0),
                    child: Image.network(
                      list[index].company_logo,
                      width: 22,
                      height: 22,
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(RecommendJob oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
