import 'package:chat_im/route/router.dart';
import 'package:chat_im/utils/constants.dart';
import 'package:chat_im/utils/data_manager.dart';
import 'package:chat_im/utils/event_bus_extend.dart';
import 'package:event_bus/event_bus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//引用event bus
EventBus eventBus = EventBus();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dataManager.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var tokenExpire;
  @override
  void initState() {
    super.initState();
    final router = FluroRouter();
    Application.router = router; // 先寫
    Routers.configureRoutes(router);
    //監聽token失效
    tokenExpire = eventBus.listening(Constants.tokenExpire, logout);
  }

  @override
  void dispose() {
    tokenExpire.cancel();
    super.dispose();
  }

  //導到登出頁面
  logout(logout) {
    Application.router.navigateTo(context, Routers.root,
        clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const WaterDropHeader(),
      footerBuilder: () => const ClassicFooter(noDataText: ''),
      hideFooterWhenNotFull: true,
      maxUnderScrollExtent: 0,
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        //這行很重要可以讓底部元件在打開鍵盤後自動頂起
        useInheritedMediaQuery: true,
        designSize: const Size(375, 750),
        builder: (context, child) {
          return MaterialApp(
            title: 'Chat',
            initialRoute: '/',
            onGenerateRoute: Application.router.generator,
          );
        },
      ),
    );
  }
}
