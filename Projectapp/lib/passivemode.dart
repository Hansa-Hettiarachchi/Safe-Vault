import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:com_project/safe_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'content_page.dart';

class Passivemode extends StatefulWidget {
  const Passivemode({Key? key}) : super(key: key);

  @override
  _PassivemodeState createState() => _PassivemodeState();
}

class _PassivemodeState extends State<Passivemode> {

  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStop: () {
      print('onStop');
    },
    onEnded: () {
      print('onEnded');
    },
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    /*_stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
    _stopWatchTimer.fetchStop.listen((value) => print('stop from stream'));
    _stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);*/

    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );

  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

   displayActive(){
    Text('Passive mode activated');
  }


  @override
  Widget build(BuildContext context) {

    TextEditingController controller = TextEditingController();
    String display = 'Passive mode activated';


    final ActivepassiveModebutton = Material(
      color: Color(0xFFc5e5f3),
      //borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
          color: Colors.red,
         // disabledColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          animationDuration: Duration(seconds: 2),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
              //show notification
            _stopWatchTimer.onExecute.add(StopWatchExecute.start);
            await AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: 123,
                  channelKey: 'basic',
                  title: 'Safe Vault',
                  body: 'Passive mode is Activated',
                  backgroundColor: Colors.red,
                  locked: true,
                  bigPicture: 'img/notify.png'
                )
            );

            var snackBar = SnackBar(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              behavior: SnackBarBehavior.floating,
              content: Text("Passive mode Activated "),
              backgroundColor: const Color(0xffe76211),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          },
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(Icons.warning_amber_rounded,color: Colors.white,),
              SizedBox(width: 30),
              Text(
                " Activate Passive mode",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 30),
              Icon(Icons.warning_amber_rounded,color: Colors.white,),
            ],
          )),
    );


    final DeactivepassiveModebutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          animationDuration: Duration(seconds: 2),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            AwesomeNotifications().dismiss(123);
            _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
            var snackBar = SnackBar(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              behavior: SnackBarBehavior.floating,
              content: Text("Passive mode Deactivated "),
              backgroundColor: const Color(0xff30a704),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          },
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(Icons.warning_amber_rounded,color: Colors.white,),
              SizedBox(width: 20),
              Text(
                " Deactivate Passive mode",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 25),
              Icon(Icons.warning_amber_rounded,color: Colors.white,),
            ],
          )),
    );


    return Scaffold(
      backgroundColor: Color(0xFADED9F8),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(" Setting up safe vault passcode "),
        centerTitle: true,
        toolbarHeight: 60.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20) )
        ),
      ),

      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only( top:55),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                /// Display stop watch time
                StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: (context, snap) {
                    final value = snap.data!;
                    final displayTime = StopWatchTimer.getDisplayTime(value, hours: _isHours);
                    return Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(
                            displayTime,
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                ),


                // Button
                Container(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 26.0,right: 26.0,bottom: 10.0,top: 10.0),
                        child: Form(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  /*Text(
                                    displayActive(),
                                    style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),*/
                                  SizedBox(height: 80,),
                                  ActivepassiveModebutton,
                                  SizedBox(height: 40,),
                                  DeactivepassiveModebutton,
                                ]
                            )
                        )
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );


  }


}
