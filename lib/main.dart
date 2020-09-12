// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'FullScreenVideoList.dart';

void main() {
  runApp(new TabbedAppBarSample());
}

class TabbedAppBarSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var app = new MaterialApp(
      home: Home(),
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );
    return app;
  }
}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement createState
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.apps),
              onPressed: () {
//                Navigator.push(context, MaterialPageRoute(builder: (context) {
//                  return MyTabView();
//                }));
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder: (context) {
//                return Search();
//              }));
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body:Container(
        decoration: BoxDecoration(color: Colors.black),
        child: FullScreenVideoList(),
      )
    );
  }
}

class Video {
  String VideoPath;
  String Img;

  Video(this.VideoPath, this.Img);
}


Widget emptyWidgetbuildCupertinoActivityIndicator() {
  return Center(child: CupertinoActivityIndicator());
}
