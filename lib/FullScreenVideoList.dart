import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Player.dart';
import 'main.dart';

class FullScreenVideoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FullScreenVideoListState();
  }
}

class FullScreenVideoListState extends State {
  List<Video> datas = new List<Video>();

  ScrollController scrollController = ScrollController();

  Size size;

  double offset = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      this.offset = scrollController.offset;
    });
    loadAsset();
  }


  Future<String> loadAsset() async {
    String data = await rootBundle.loadString('assets/data.json');
    List<dynamic> list = jsonDecode(data);
    list.forEach((element) {
      print(element["coverImgUrl"]);
      print(element["url"]);
      datas.add(Video(element["url"],element["coverImgUrl"]));
    });
    setState(() {

    });
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    size = MediaQuery.of(context).size;
    setState(() {});
  }

  int curPlayPosition = 0;

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  Widget _buildWidget() {
    if (datas.length <= 0 || size == null) {
      return emptyWidgetbuildCupertinoActivityIndicator();
    } else {
      var list = GridView.builder(
          controller: scrollController,
          physics: PageScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: datas.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 1,
              //纵轴间距
              mainAxisSpacing: 0.0,
              //横轴间距
              crossAxisSpacing: 0.0,
              //子组件宽高长度比例
              childAspectRatio: size.width / size.height),
          itemBuilder: (context, i) {
            if (i == curPlayPosition) {
              return _buildPlay(datas[i]);
            } else {
              return _buildItem(datas[i]);
            }
          });
      return NotificationListener<ScrollEndNotification>(
          onNotification: onscroll, child: list);
    }
  }

  Widget _buildItem(Video data) {
    return Stack(
      children: [
        Image(
            width: size.width,
            height: size.height,
            image: NetworkImage(data.Img),
            fit: BoxFit.cover,
            alignment: Alignment.center)
      ],
    );
  }

  bool onscroll(ScrollEndNotification notification) {
    var playPosition = (offset / size.height).ceil();
    //todo 需要关注这里的问题，算出来的位置会大于实际位置，仅发生在列表最后一个，
    if (playPosition != curPlayPosition && playPosition < datas.length) {
      curPlayPosition = playPosition;
      print("setState");
      print(playPosition);
      print(curPlayPosition);
      setState(() {});
    }
  }

  Widget _buildPlay(Video data) {
    return Player(data);
  }
}
