import 'package:flutter/material.dart';
import 'package:flutter_shows/model/BannerResponse.dart';
import 'package:flutter_shows/model/HomeListResponse.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';
import 'package:flutter_shows/common/global.dart';

class JobPage extends StatefulWidget {
  @override
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  double statusHeight;
  double screenWidth = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _requestBanner();
    _requestHomeList();
    _scrollController.addListener((){
      print('offset----->${_scrollController.offset}');
    });
  }

  void _requestBanner() {
    CommonRequest.requestBanner().then((result) {
      BannerResponse bannerResponse = BannerResponse.fromJson(result);
      if (bannerResponse.code == 0) {
        setState(() {
          imgs = bannerResponse.data.list;
        });
      } else {}
    });
  }

  void _requestHomeList() {
    Map<String, dynamic> param = {
      'max_age': 100,
      'max_salary': 30000,
      'high_salary': 0,
      'min_salary': 1000,
      'lon': '121.52424',
      'lat': '31.232044',
      'page': 1,
      'category': 0,
      'min_age': 16,
      'gender_require': 0,
      'page_size': 10,
    };
    CommonRequest.requestJobList(params: param).then((result) {
      HomeListResponse homeListResponse = HomeListResponse.fromJson(result);
      if (homeListResponse.code == 0) {
        setState(() {
          list = homeListResponse.data.data;
        });
      } else {}
    });
  }

  _clickSearchBox() {}

  @override
  Widget build(BuildContext context) {
    statusHeight = MediaQuery.of(context).padding.top; //状态栏的高度
    screenWidth = ScreenUtil.getScreenW(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          _searchBox(),
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: _bannerView(),
                ),
                SliverToBoxAdapter(
                  child: _btnViews(),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _SliverAppBarDelegate(
                      minHeight: 43, maxHeight: 43, child: _selectViews()),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 8),
                  sliver: _listView(),
                )
              ],
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  Widget _listView() {
    return SliverStaggeredGrid.countBuilder(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        staggeredTileBuilder: (_) => StaggeredTile.fit(1),
        itemBuilder: (BuildContext context, int index) => _jobItem(list, index),
        itemCount: list.length);
  }

  List<BannerInfo> imgs = List<BannerInfo>();
  List<HomeListInfo> list = List<HomeListInfo>();

  String _wapperImgUrl(int index) {
    if (imgs == null && imgs.length == 0) {
      return "";
    } else {
      return imgs[index].img_url;
    }
  }

  Widget _bannerView() {
    return Container(
      width: double.infinity,
      height: 112,
      child: PageView.builder(
        //相当于ViewPager
        itemBuilder: ((context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, WEBVIEW_ROUTE, arguments: {
                  'title': imgs[index].title,
                  'url': imgs[index].url_link
                });
              },
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: Image.network(
                    _wapperImgUrl(index),
                    width: double.infinity,
                    height: 112,
                    fit: BoxFit.fill,
                  ),
                ),
              ));
        }),
        itemCount: imgs.length,
        scrollDirection: Axis.horizontal,
        reverse: false,
      ),
    );
  }

  Widget _searchBox() {
    return Padding(
      padding: EdgeInsets.only(
          left: 20, top: 13 + statusHeight, right: 20, bottom: 10),
      child: GestureDetector(
        onTap: _clickSearchBox,
        child: Container(
          height: 30,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(2.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Utils.wapperResourcePath('icon_sousuo.png'),
                height: 14,
                width: 14,
              ),
              Text(
                ' 搜索您想查找的企业/岗位/标签',
                style: TextStyle(color: Color(0xFF696969), fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectViews() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _selectView(' 岗位类型'),
              flex: 1,
            ),
            Expanded(
              child: _selectView(' 招聘信息'),
              flex: 1,
            ),
            Expanded(
              child: _selectView(' 吃住信息'),
              flex: 1,
            ),
            Expanded(
              child: _selectView(' 岗位信息'),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _selectView(String type) {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: GestureDetector(
        onTap: () {
          _scrollController.animateTo(240.0,
              curve: Curves.ease,
              duration: Duration(milliseconds: 400));
        },
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(2.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                type,
                style: TextStyle(fontSize: 12, color: Color(0xff696969)),
              ),
              Image.asset(
                Utils.wapperResourcePath('triangle_shang.png'),
                height: 10,
                width: 15,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _btnViews() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _cellWidget(
                  '急招岗位', Utils.wapperResourcePath('but_jzgw.png'), 0),
              flex: 1,
            ),
            Expanded(
              child: _cellWidget(
                  '超市零售', Utils.wapperResourcePath('but_csls.png'), 1),
              flex: 1,
            ),
            Expanded(
              child: _cellWidget(
                  '物流仓储', Utils.wapperResourcePath('but_wlcc.png'), 2),
              flex: 1,
            ),
            Expanded(
              child: _cellWidget(
                  '包吃包住', Utils.wapperResourcePath('but_bcbz.png'), 3),
              flex: 1,
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: _cellWidget(
                  '快速入职', Utils.wapperResourcePath('but_ksrz.png'), 4),
              flex: 1,
            ),
            Expanded(
              child: _cellWidget(
                  '高薪工作', Utils.wapperResourcePath('but_gxgz.png'), 5),
              flex: 1,
            ),
            Expanded(
              child: _cellWidget(
                  '餐饮服务', Utils.wapperResourcePath('but_cyfw.png'), 6),
              flex: 1,
            ),
            Expanded(
              child: _cellWidget(
                  '热门推荐', Utils.wapperResourcePath('but_emtj.png'), 7),
              flex: 1,
            )
          ],
        )
      ],
    );
  }

  _cellClick(int type) {}

  Widget _cellWidget(String title, String path, int type) {
    return GestureDetector(
      onTap: _cellClick(type),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            path,
            width: 30,
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              title,
              style: TextStyle(color: Color(0xFF2c2c2c), fontSize: 13),
            ),
          )
        ],
      ),
    );
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
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
