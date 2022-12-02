import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';

import '../utils/Constants.dart';

class NotificationService {
  Future<void> sendPushNotifications(String title, String content, {String? id, String? image, String? receiverPlayerId}) async {
    log(receiverPlayerId!);
    Map req = {
      'headings': {
        'en': title,
      },
      'contents': {
        'en': content,
      },
      'big_picture': image.validate().isNotEmpty ? image.validate() : '',
      'large_icon': image.validate().isNotEmpty ? image.validate() : '',
   //   'small_icon': mAppIconUrl,
      'app_id': mOneSignalAppId,
      'android_channel_id': mOneSignalChannelID,
      'include_player_ids': [receiverPlayerId],
      'android_group': mAppName,
    };
    var header = {
      HttpHeaders.authorizationHeader: 'Basic $mOneSignalRestKey',
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    };

    Response res = await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      body: jsonEncode(req),
      headers: header,
    );

    log(res.body);

    if (res.statusCode.isEven) {
    } else {
      throw 'Something Went Wrong';
    }
  }
}
