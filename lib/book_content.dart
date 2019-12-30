import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookContent extends StatefulWidget {
  @override
  _BookContentState createState() => _BookContentState();
}

class _BookContentState extends State<BookContent> {
  List<Map<String, int>> pageConfig = [];
  Map ajaxData = {};
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    getBookContent(1);
  }

  getPageOffsets(String content, double height, double width, double fontSize) {
    String tempStr = content;
    List<Map<String, int>> pageConfigTemp = [{}];
    int last = 0;
    while (true) {
      Map<String, int> offset = {};
      offset['start'] = last;
      TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
//        locale: Locale('zh', 'CH'),
      );
      textPainter.text = TextSpan(
        text: tempStr,
        style: TextStyle(
          fontSize: fontSize,
          height: 1.5,
          fontFamily: 'SourceHanSerifCN',
        ),
      );
      textPainter.layout(maxWidth: width);
      var end = textPainter.getPositionForOffset(Offset(width, height)).offset;

      if (end == 0) {
        break;
      }
      tempStr = tempStr.substring(end, tempStr.length);
      offset['end'] = last + end;
      last = last + end;
      pageConfigTemp.add(offset);
    }
    setState(() {
      pageConfig = pageConfigTemp;
    });
//    return pageConfig;
//    print(pageConfig);
  }

  getBookContent(id, {flag}) async {
    Response res = await Dio().post(
      "http://www.zhengw.top/getContent",
      data: {'id': id, 'books_id': 1},
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
//          'X-Requested-With': 'XMLHttpRequest',
          'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
        },
      ),
    );
    setState(() {
      ajaxData = res.data;
      getPageOffsets(
        ajaxData['0']['content'],
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 16 * 1.5,
        MediaQuery.of(context).size.width - 40,
        16,
      );
      _controller.jumpToPage(flag == 'prev' ? pageConfig.length - 1 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemBuilder: ((context, index) {
            return ajaxData.isEmpty
                ? Container(
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: SingleChildScrollView(
                      child: index == pageConfig.length || index == 0
                          ? Container(
                              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            )
                          : Text(
                              '${ajaxData['0']['content'].substring(pageConfig[index]['start'], pageConfig[index]['end'])}',
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 16,
                                fontFamily: 'SourceHanSerifCN',
                              ),
                            ),
                    ),
                  );
          }),
          itemCount: pageConfig.length + 1,
          onPageChanged: (index) {
            setState(() {
              index = index;
              if (index == pageConfig.length && ajaxData['next'] != '') {
                getBookContent(ajaxData['next'], flag: 'next');
              } else if (index == 0 && ajaxData['prev'] != '') {
                getBookContent(ajaxData['prev'], flag: 'prev');
              }
            });
          },
        ),
      ),
    );
  }
}
