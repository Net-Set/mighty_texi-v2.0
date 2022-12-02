import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxi_driver/utils/Common.dart';
import 'package:taxi_driver/utils/Extensions/StringExtensions.dart';
import '../../main.dart';
import '../model/ChatMessageModel.dart';
import '../utils/Colors.dart';
import '../utils/Constants.dart';
import '../utils/Extensions/ConformationDialog.dart';
import '../utils/Extensions/Loader.dart';
import '../utils/Extensions/app_common.dart';

class ChatItemWidget extends StatefulWidget {
  final ChatMessageModel? data;

  ChatItemWidget({this.data});

  @override
  _ChatItemWidgetState createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  String? images;

  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  Widget build(BuildContext context) {
    String time;

    DateTime date = DateTime.fromMicrosecondsSinceEpoch(widget.data!.createdAt! * 1000);
    if (date.day == DateTime.now().day) {
      time = DateFormat('hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(widget.data!.createdAt! * 1000));
    } else {
      time = DateFormat('dd-mm-yyyy hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(widget.data!.createdAt! * 1000));
    }

    Widget chatItem(String? messageTypes) {
      switch (messageTypes) {
        case TEXT:
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: widget.data!.isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(widget.data!.message!, style: primaryTextStyle(color: widget.data!.isMe! ? Colors.white : textPrimaryColorGlobal), maxLines: null),
              SizedBox(height: 1),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    time,
                    style: primaryTextStyle(color: !widget.data!.isMe.validate() ? Colors.blueGrey.withOpacity(0.6) : Colors.white.withOpacity(0.6), size: 10),
                  ),
                  SizedBox(height: 2),
                  widget.data!.isMe!
                      ? !widget.data!.isMessageRead!
                          ? Icon(Icons.done, size: 12, color: Colors.white60)
                          : Icon(Icons.done_all, size: 12, color: Colors.white60)
                      : Offstage()
                ],
              ),
            ],
          );
        case IMAGE:
          if (widget.data!.photoUrl.validate().isNotEmpty || widget.data!.photoUrl != null) {
            return Stack(
              children: [
                ClipRRect(
                  borderRadius: radius(16),
                  child: commonCachedNetworkImage(widget.data!.photoUrl.validate(), fit: BoxFit.contain, width: 250),
                ),
                Positioned(
                    bottom: 8,
                    right: 8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          time,
                          style: primaryTextStyle(
                            color: !widget.data!.isMe.validate() ? Colors.blueGrey.withOpacity(0.6) : Colors.white.withOpacity(0.6),
                            size: 10,
                          ),
                        ),
                        SizedBox(height: 2),
                        widget.data!.isMe!
                            ? !widget.data!.isMessageRead!
                                ? Icon(Icons.done, size: 12, color: Colors.white60)
                                : Icon(Icons.done_all, size: 12, color: Colors.white60)
                            : Offstage()
                      ],
                    ))
              ],
            );
          } else {
            return Container(child: Loader(), height: 250, width: 250);
          }
        default:
          return Container();
      }
    }

    EdgeInsetsGeometry customPadding(String? messageTypes) {
      switch (messageTypes) {
        case TEXT:
          return EdgeInsets.symmetric(horizontal: 12, vertical: 8);
        case IMAGE:
          return EdgeInsets.symmetric(horizontal: 4, vertical: 4);
        case VIDEO:
          return EdgeInsets.symmetric(horizontal: 4, vertical: 4);
        case AUDIO:
          return EdgeInsets.symmetric(horizontal: 4, vertical: 4);
        default:
          return EdgeInsets.symmetric(horizontal: 4, vertical: 4);
      }
    }

    return GestureDetector(
      onLongPress: !widget.data!.isMe!
          ? null
          : () async {
              bool? res = await showConfirmDialogCustom(context, positiveText: 'Yes', negativeText: 'No', primaryColor: primaryColor, onAccept: (BuildContext context) {});
              if (res ?? false) {
                hideKeyboard(context);
                chatMessageService.deleteSingleMessage(senderId: widget.data!.senderId, receiverId: widget.data!.receiverId!, documentId: widget.data!.id).then((value) {
                  //
                }).catchError(
                  (e) {
                    log(e.toString());
                  },
                );
              }
            },
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: widget.data!.isMe.validate() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: widget.data!.isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              margin: widget.data!.isMe.validate()
                  ? EdgeInsets.only(top: 0.0, bottom: 0.0, left: isRTL ? 0 : MediaQuery.of(context).size.width * 0.25, right: 8)
                  : EdgeInsets.only(top: 2.0, bottom: 2.0, left: 8, right: isRTL ? 0 : MediaQuery.of(context).size.width * 0.25),
              padding: customPadding(widget.data!.messageType),
              decoration: BoxDecoration(
                boxShadow: appStore.isDarkMode ? null : defaultBoxShadow(),
                color: widget.data!.isMe.validate() ? primaryColor : scaffoldColorLight,
                borderRadius: widget.data!.isMe.validate()
                    ? BorderRadius.only(bottomLeft: radiusCircular(12), topLeft: radiusCircular(12), bottomRight: radiusCircular(12), topRight: radiusCircular(12))
                    : BorderRadius.only(bottomLeft: radiusCircular(0), topLeft: radiusCircular(12), bottomRight: radiusCircular(12), topRight: radiusCircular(12)),
              ),
              child: chatItem(widget.data!.messageType),
            ),
          ],
        ),
        margin: EdgeInsets.only(top: 2, bottom: 2),
      ),
    );
  }
}
