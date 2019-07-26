import 'package:flutter/material.dart';
import 'package:fluttie/fluttie.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  FluttieAnimationController whaleController;

  void prepareLottie() async {
    var instance = Fluttie();
    var whaleLottie =
        await instance.loadAnimationFromAsset('assets/json/loading.json');
    whaleController = await instance.prepareAnimation(whaleLottie,
        repeatCount: const RepeatCount.infinite());
    whaleController.start();
  }

  @override
  void initState() {
    super.initState();
    prepareLottie();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FluttieAnimation(whaleController, size: Size(600, 600)),
    );
  }
}
