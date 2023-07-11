class Constants{
  static TokyoUrlConst tokyoUrlConst = const TokyoUrlConst();
  static MessageConst messageConst = const MessageConst();
  static PathConst pathConst = const PathConst();
}

class TokyoUrlConst{
  const TokyoUrlConst();
  String get tokyocheapo => "https://tokyocheapo.com/feed/";
}

class MessageConst{
  const MessageConst();
  String get loadingFeedMsg => "Loading Feed...";
  String get errorLoadingFeedMsg => "Error Loadşng Feed.";
}

class PathConst{
  const PathConst();
  String get placeHolderImg => "images/no-image.png";
}