import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_nb/constants/constants.dart';
import 'package:flutter_nb/database/message_database.dart';
import 'package:flutter_nb/ui/widget/loading_widget.dart';
import 'package:flutter_nb/ui/widget/more_widgets.dart';
import 'package:flutter_nb/ui/widget/popupwidow_widget.dart';
import 'package:flutter_nb/utils/dialog_util.dart';
import 'package:flutter_nb/utils/file_util.dart';
import 'package:flutter_nb/utils/functions.dart';
import 'package:flutter_nb/utils/interact_vative.dart';
import 'package:flutter_nb/utils/notification_util.dart';
import 'package:flutter_nb/utils/object_util.dart';
import 'package:flutter_nb/utils/sp_util.dart';

/*
*  我的
*/
class MinePage extends StatefulWidget {
  MinePage({Key key, this.title, this.operation, this.rootContext})
      : super(key: key);
  final String title;
  final Operation operation;
  final BuildContext rootContext;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MineState();
  }
}

class _MineState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  File imageChild;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MoreWidgets.buildAppBar(context, '',
            elevation: 0.0, height: 56, actions: _actions(context)),
        body: ListView(
          children: <Widget>[
            MoreWidgets.mineListViewItem1(
                SPUtil.getString(Constants.KEY_LOGIN_ACCOUNT),
                content: '萍水相逢，尽是他乡之客',
                imageChild: _getHeadPortrait(), onImageClick: (res) {
              PopupWidowUtil.showPhotoChosen(context, onCallBack: (image) {
                setState(() {
                  imageChild = image;
                });
              });
            }),
            MoreWidgets.buildDivider(),
            MoreWidgets.defaultListViewItem(Icons.add_shopping_cart, '支付',
                textColor: Colors.black),
            MoreWidgets.defaultListViewItem(Icons.favorite, '收藏',
                textColor: Colors.black),
            MoreWidgets.defaultListViewItem(Icons.photo, '相册',
                textColor: Colors.black),
            MoreWidgets.defaultListViewItem(Icons.content_copy, '卡包',
                textColor: Colors.black),
            MoreWidgets.defaultListViewItem(Icons.face, '表情',
                textColor: Colors.black),
            MoreWidgets.defaultListViewItem(Icons.settings, '设置',
                textColor: Colors.black, isDivider: false, onItemClick: (res) {
              NotificationUtil.build().showChat(
                  '聊天消息',
                  '后来也怕了，我也不想租了。不过说实话，那地方住的很舒服，很安静，很大。',
                  Constants.MESSAGE_TYPE_CHAT);
//              NotificationUtil.build().showSystem('系统消息',
//                  '您收到一个好友添加邀请，请求添加您为好友！', Constants.MESSAGE_TYPE_SYSTEM);
            }),
            MoreWidgets.buildDivider(),
            MoreWidgets.defaultListViewItem(Icons.exit_to_app, '退出',
                textColor: Colors.black, isDivider: false, onItemClick: (res) {
              _logOut();
            }),
            MoreWidgets.buildDivider(),
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  List<Widget> _actions(BuildContext context) {
    List<Widget> actions = new List();
    Widget widget = InkWell(
        child: Container(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Icon(
              Icons.add_a_photo,
              size: 22,
            )),
        onTap: () {
          PopupWidowUtil.showPhotoChosen(context);
        });
    actions.add(widget);
    return actions;
  }

  Widget _getHeadPortrait() {
    if (null != imageChild) {
      return Image.file(imageChild, width: 62, height: 62);
    }
    return Image.asset(
        FileUtil.getImagePath('logo', dir: 'splash', format: 'png'),
        width: 62,
        height: 62);
  }

  _logOut() {
    widget.operation.setShowLoading(true);
    InteractNative.goNativeWithValue(InteractNative.methodNames['logout'])
        .then((success) {
      widget.operation.setShowLoading(false);
      if (success == true) {
        DialogUtil.buildToast('登出成功');
        ObjectUtil.doExit(widget.rootContext);
      } else if (success is String) {
        DialogUtil.buildToast(success);
      } else {
        DialogUtil.buildToast('登出失败');
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
