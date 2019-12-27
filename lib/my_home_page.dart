import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:flutter/services.dart';
import 'package:weread_ink_flutter/book_desc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  double width;

  List bookshelf = [
    {'name': '围城', 'img': 'ia_100000001.jpg'},
    {'name': '平凡的世界（全三册）', 'img': 'ia_100000002.jpg'},
    {'name': '三体（全三册）', 'img': 'ia_100000003.jpg'},
    {'name': '人生', 'img': 'ia_100000004.jpg'},
  ];

  List recommendBooks = [
    {'name': '围城', 'img': 'ia_100000001.jpg'},
    {'name': '平凡的世界（全三册）', 'img': 'ia_100000002.jpg'},
    {'name': '三体（全三册）', 'img': 'ia_100000003.jpg'},
  ];

  List topBooks = [
    {
      'img': 'top_1.jpg',
      'list': [
        {'name': '雪中悍刀行（全集）', 'img': 'ia_100000005.jpg', 'author': '烽火戏诸侯'},
        {'name': '撒哈拉的故事', 'img': 'ia_100000006.jpg', 'author': '三毛'},
        {'name': '一禅小和尚', 'img': 'ia_100000007.jpg', 'author': '一禅小和尚'},
      ],
    },
    {
      'img': 'top_2.jpg',
      'list': [
        {'name': '雪中悍刀行（全集）', 'img': 'ia_100000008.jpg', 'author': '烽火戏诸侯'},
        {'name': '撒哈拉的故事', 'img': 'ia_100000009.jpg', 'author': '三毛'},
        {'name': '一禅小和尚', 'img': 'ia_100000010.jpg', 'author': '一禅小和尚'},
      ],
    },
    {
      'img': 'top_3.jpg',
      'list': [
        {'name': '雪中悍刀行（全集）', 'img': 'ia_100000011.jpg', 'author': '烽火戏诸侯'},
        {'name': '撒哈拉的故事', 'img': 'ia_100000012.jpg', 'author': '三毛'},
        {'name': '一禅小和尚', 'img': 'ia_100000013.jpg', 'author': '一禅小和尚'},
      ],
    },
    {
      'img': 'top_4.jpg',
      'list': [
        {'name': '雪中悍刀行（全集）', 'img': 'ia_100000014.jpg', 'author': '烽火戏诸侯'},
        {'name': '撒哈拉的故事', 'img': 'ia_100000015.jpg', 'author': '三毛'},
        {'name': '一禅小和尚', 'img': 'ia_100000016.jpg', 'author': '一禅小和尚'},
      ],
    },
  ];

  String highlightIndex;
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    _context = context;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  Widget moreColumn(data, count) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data.map<Widget>(
          (item) {
            return Container(
              width: (width - 100) / count,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    highlightColor: Colors.black,
                    onHighlightChanged: (val) {
                      print('$val');
                      if (!val) {
                        Navigator.push(
                          _context,
                          MaterialPageRoute(
                            builder: (context) => BookDesc(),
                          ),
                        );
                      }
                    },
                    onTap: () {},
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Image.asset(
                            'images/${item['img']}',
                          ),
                        ),
                        Positioned(
                          left: -2,
                          top: -2,
                          child: InkWell(
                            onTap: () {},
                            highlightColor: Colors.black,
                            child: Container(
                              width: (width - 100) / count + 4,
                              height: 4.0 + ((width - 100) / count * 360) ~/ 250,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${item['name']}',
                    maxLines: count == 3 ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: 56,
            ),
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),

                    //SliverAppBar也可以实现吸附在顶部的TabBar，但是高度不好计算，总是会有AppBar的空白高度，
                    //所以我就用了SliverPersistentHeader来实现这个效果，SliverAppBar的bottom中只放TabBar顶部的布局
                    child: SliverAppBar(
                      expandedHeight: 56,
                      forceElevated: innerBoxIsScrolled,

                      //TabBar顶部收缩的部分
                      flexibleSpace: Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                        ),
                        height: 56,
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'images/wread_top.jpg',
                          fit: BoxFit.contain,
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                  //停留在顶部的TabBar
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      child: Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                        height: 46 + MediaQuery.of(context).padding.top,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(56),
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              border: InputBorder.none,
                              hintText: '长安十二时辰',
                              hintStyle: TextStyle(
                                color: Color(0xff999999),
                              ),
                            ),
                          ),
                        ),
                      ),
                      minHeight: 46 + MediaQuery.of(context).padding.top,
                      maxHeight: 46 + MediaQuery.of(context).padding.top,
                    ),
                    pinned: true,
                  ),
                ];
              },
              pinnedHeaderSliverHeightBuilder: () {
                return 46 + MediaQuery.of(context).padding.top;
              },
              body: ListView(
                padding: EdgeInsets.all(24),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                ),
                                width: 46,
                                height: 46,
                                child: ClipOval(
                                  child: Image.asset('images/yu.jpg'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 46,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      '简单快乐',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      '无限卡110天',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                '进入书架',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  moreColumn(bookshelf, 4),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    height: 1,
                    color: Colors.black,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            '为你推荐',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 26,
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(26),
                            ),
                          ),
                          child: Text(
                            '换一批',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  moreColumn(recommendBooks, 3),
                  Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    height: 1,
                    color: Colors.black,
                  ),
                  Wrap(
                    children: topBooks.map<Widget>(
                      (item) {
                        int index = topBooks.indexOf(item);
                        return Container(
                          width: (width - 48 - 20) / 2,
                          margin: EdgeInsets.only(
                            right: index % 2 == 1 ? 0 : 10,
                            left: index % 2 == 0 ? 0 : 10,
                            bottom: 20,
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 40,
                                margin: EdgeInsets.only(bottom: 20),
                                child: Image.asset(
                                  'images/${item['img']}',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Column(
                                children: item['list'].map<Widget>(
                                  (list) {
                                    return Container(
                                      child: InkWell(
                                        highlightColor: Colors.black,
                                        onHighlightChanged: (val) {
                                          setState(() {
                                            if (val) {
                                              highlightIndex = '$index${item['list'].indexOf(list)}';
                                            } else {
                                              highlightIndex = null;
                                            }
                                          });
                                        },
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: 6,
                                            bottom: 6,
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: (width - 48) / 2 / 3,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                child: Image.asset(
                                                  'images/${list['img']}',
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 4,
                                                  right: 4,
                                                ),
                                                child: Text(
                                                  '${item['list'].indexOf(list) + 1}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: highlightIndex == '$index${item['list'].indexOf(list)}'
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      '${list['name']}',
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: highlightIndex == '$index${item['list'].indexOf(list)}'
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      '${list['author']}',
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: highlightIndex == '$index${item['list'].indexOf(list)}'
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.only(top: 20),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '查看全部',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              height: 56,
              width: width,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
                  ),
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.keyboard_arrow_up,
                          size: 32,
                        ),
                        Text('上一页'),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 32,
                        ),
                        Text('下一页'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
