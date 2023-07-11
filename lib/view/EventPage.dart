import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cityevents/core/Constants.dart';

class EventPage extends StatefulWidget {
  EventPage() : super();
  final String title = 'Event Page';

  @override
  EventPageState createState() => EventPageState();
}

class EventPageState extends State<EventPage> {

  RssFeed _feed;
  String _title;


  @override
  void initState() {
    super.initState();
    updateTitle(widget.title);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title),),
      body: body(),
    );
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(Constants.tokyoUrlConst.tokyocheapo);
      return RssFeed.parse(response.body);
    } catch (e) {
      print("loadFeed method failed: " + e.toString());
      return null;
    }
  }

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  load() async {
    updateTitle(Constants.messageConst.loadingFeedMsg);
    loadFeed().then((result) {
      if (result == null || result
          .toString()
          .isEmpty) {
        updateTitle(Constants.messageConst.errorLoadingFeedMsg);
      }

      updateFeed(result);
      updateTitle(_feed.title);
    });
  }

  title(title) {
    return Text(title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    )
  }

  subTitle(subTitle) {
    return Text(subTitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    )
  }

  Thumbnail(imageUrl) {
    return Padding(padding: EdgeInsets.only(left: 15.0),
      child: CachedNetworkImage(
        placeholder: (context, url) =>
            Image.asset(Constants.pathConst.placeHolderImg),
        imageUrl: imageUrl,
        height: 50,
        width: 70,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  rightIcon() {
    return Icon(
        Icon(
          Icons.keyboard_arrow_right,
          color: Colors.green,
          size: 30.0,
        )
    );
  }

  list() {
    return ListView.builder(itemCount: _feed.items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _feed.items[index];
          return ListTile(
            title: title(item.title),
            subtitle: subTitle(item.pubDate),
            leading: Thumbnail(item.enclosure.url),
            trailing: rightIcon(),
            contentPadding: EdgeInsets.all(5.0),
            onTap: () {

            },
          );
        });
  }

  isFeedEmpty() {
    return _feed == null || _feed.items == null;
  }

  body() {
    return isFeedEmpty() ? Center(child: CircularProgressIndicator(),) : list();
  }

}
